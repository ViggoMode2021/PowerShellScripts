#
# One time setup:
#
# - Open all sites on the list in all browsers
# - Log on the test user UXMetricsGuyA (where applicable)
# - Switch the browser window to full screen
# - Config per site:
#   - Accept cookie popups
#   - Do not accept a site's notifications
#     - Enable "stay signed in" where applicable
# - Config per browser:
#   - Configure browser startup to not open previous tabs
#   - Configure start page: "about:blank"
#   - Do not save passwords in the browser
#   - Disable browser dialogs:
#     - asking about not being the default
#     - asking if you want to close all tabs
#
# Before each test run:
#
# - Empty each browser's cache
#   - Do not delete cookies
# - Close all browsers
# - Restart the machine
# - Log on as test user test01
# - Start a PowerShell console   
# - Wait five minutes
# - Start this script
#

#
# Global variables
#
# How long to wait between open site commands
$waitBetweenSitesS = 30;
# How long to wait after a browser's last site before closing its window
$waitBeforeBrowserClose = 30;
# How long to wait between browsers
$waitBetweenBrowsers = 30;

# Name of the file containing the sites to open
$siteUrlFile = ".\URLs.txt";

# Number of iterations
$iterations = 3;

# Browsers to start
$browsers = @("chrome", "firefox", "iexplore")

#
# Start of the script
#

# Read the sites file
$sites = Get-Content $siteUrlFile;

# Iterations
for ($i = 1; $i -le $iterations; $i++)
{
   Write-Host "Iteration: " $i

   # Browsers
   foreach ($browser in $browsers)
   {
      # Sites
      $siteCount = 0;
      foreach ($site in $sites)
      {
         $siteCount++;
      
         if ($siteCount -eq 1)
         {
            if ($browser -eq "chrome" -or $browser -eq "firefox")
            {
               # Start the browser with an empty tab because the first page load is currently not captured by uberAgent
               $process = Start-Process -PassThru $browser "about:blank"
            }
            else
            {
               # Start the browser with the first site
               $process = Start-Process -PassThru $browser $site
            }
               
            # Store the browser's main process (the first one started)
            $browserProcess = $process;
            
            # Wait for the window to open
            while ($process.MainWindowHandle -eq 0)
            {
               Start-Sleep 1
            }
            
            if ($browser -eq "chrome" -or $browser -eq "firefox")
            {
               # Open the first site in a new tab
               Start-Process $browser $site
            }
         }
         elseif ($browser -eq "iexplore")
         {
            # Additional IE tabs need to be opened differently, or new windows will be created instead
            
            $navOpenInNewTab = 0x800;
            
            # Get running Internet Explorer instances
            $app = New-Object -ComObject shell.application;
            
            # Grab the last opened tab
            $ie = $app.Windows() | Select-Object -Last 1;
            
            # Open the site in a new tab
            $ie.navigate($site, $navOpenInNewTab);
            
            # Release the COM objects
            Remove-Variable ie;
            Remove-Variable app;
         }
         else
         {
            # Addition tabs in Chrome/Firefox
            Start-Process $browser $site
         }
         
         Start-Sleep $waitBetweenSitesS;
      }
      
      Start-Sleep $waitBeforeBrowserClose;
      
      # Close the browser
      $browserProcess.CloseMainWindow();
      $browserProcess = $null;
      
      Start-Sleep $waitBetweenBrowsers;
   }
}
