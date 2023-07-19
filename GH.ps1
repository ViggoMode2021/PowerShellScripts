<#
Invoke-WebRequest 'https://github.com/ViggoMode2021/PowerShellScripts/archive/refs/heads/main.zip' -OutFile .\PowerShellScripts.zip
Expand-Archive .\PowerShellScripts.zip .\
Rename-Item .\PowerShellScripts-main .\PowerShellScripts
Remove-Item .\PowerShellScripts.zip
#>

# https://4sysops.com/archives/powershell-invoke-webrequest-parse-and-scrape-a-web-page/

# https://pipe.how/invoke-webscrape/

# https://blog.ironmansoftware.com/daily-powershell/powershell-download-github/

$GitHub_Profile_Name = Read-Host "What is the name of the GitHub profile you would like to use?"

$GitHub_Profile_Name_Length = $GitHub_Profile_Name.Length

$URL_Suffix = $GitHub_Profile_Name + '?tab=repositories'

$URL = "https://github.com/$URL_Suffix"

$Site = Invoke-WebRequest $URL

$GitHub_Profile_Name_With_Slashes = '/' + $GitHub_Profile_Name + '/'

$Links = $Site.Links | Select href | Out-String

Write-Host $Links -join ""

#$Position = $Yes.IndexOf("/")

#$Before = $Yes.Substring($GitHub_Profile_Name_Length , $Position)

#Write-Host $Before

#$After = $Yes.Substring($Position+1)


