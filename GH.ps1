<#
Invoke-WebRequest 'https://github.com/ViggoMode2021/PowerShellScripts/archive/refs/heads/main.zip' -OutFile .\PowerShellScripts.zip
Expand-Archive .\PowerShellScripts.zip .\
Rename-Item .\PowerShellScripts-main .\PowerShellScripts
Remove-Item .\PowerShellScripts.zip
#>

# https://4sysops.com/archives/powershell-invoke-webrequest-parse-and-scrape-a-web-page/

# https://pipe.how/invoke-webscrape/

# https://blog.ironmansoftware.com/daily-powershell/powershell-download-github/

$DesktopPath = [Environment]::GetFolderPath("Desktop")

$GitHub_Profile_Name = Read-Host "What is the name of the GitHub profile you would like to use?"

$GitHub_Profile_Name_Length = $GitHub_Profile_Name.Length

$URL_Suffix = $GitHub_Profile_Name + '?tab=repositories'

$URL = "https://github.com/$URL_Suffix"

$Site = Invoke-WebRequest $URL

$GitHub_Profile_Name_With_Slashes = '/' + $GitHub_Profile_Name + '/'

$Links = $Site.Links | Select href | Export-CSV .\GitHub-Links.csv

$GitHub_Links = Import-CSV -Path .\GitHub-Links.csv

foreach ($Link in $GitHub_Links) {

$Link = $Link.href

if($Link -match $GitHub_Profile_Name_With_Slashes) {

$Base_URL = "https://github.com/"

$URL_Suffix_Zip = "/archive/refs/heads/main.zip"

$Full_Url = $Base_URL + $Link + $URL_Suffix_Zip

$Index = "/" + $GitHub_Profile_Name + "/"

$Repository = $Link.replace("$Index","")

Write-Host $Repository

#Write-Host $Repository -ForeGroundColor "Cyan"

#Write-Host $Full_Url -ForeGroundColor "Green"

if(Test-Path "$DesktopPath\GitHub-Repositories-$GitHub_Profile_Name"){

Write-Host "Directory exists on desktop titled 'GitHub-Repositories-$GitHub_Profile_Name'. Downloading repositories to said directory" 

#Invoke-WebRequest $Full_Url -OutFile .\$Work.zip 
#Expand-Archive '$DesktopPath\GitHub-Repositories-For-$GitHub_Profile_Name\$Link.zip' '$DesktopPath\GitHub-Repositories-For-$GitHub_Profile_Name'
#Rename-Item .\PowerShellScripts-main .\PowerShellScripts
#Remove-Item .\PowerShellScripts.zip

}

else{

New-Item -Path "$DesktopPath\GitHub-Repositories-$GitHub_Profile_Name" -ItemType Directory

Invoke-WebRequest 'https://github.com/ViggoMode2021/PowerShellScripts/archive/refs/heads/main.zip' -OutFile .\PowerShellScripts.zip
Expand-Archive .\PowerShellScripts.zip .\
#Rename-Item .\PowerShellScripts-main .\PowerShellScripts
#Remove-Item .\PowerShellScripts.zip

}



}

}
