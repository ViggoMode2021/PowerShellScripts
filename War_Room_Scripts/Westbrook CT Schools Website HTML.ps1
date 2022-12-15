$User = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-not $User.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )) {
	Write-Host 'Please run again with Administrator privileges.' -ForegroundColor Red
    if ($RunScriptSilent -NE $True){
        Read-Host 'Press [Enter] to exit'
    }
    exit
}

function get_html{

$Item_Path = "C:/Users/ryans/Desktop/html_webpages"

New-Item -Path $Item_Path -ItemType directory

wget https://www.westbrookctschools.org/ -OutFile main_page.html

Write-Host 'Success for main_page.html!' -ForegroundColor Green

wget https://www.westbrookctschools.org/directory/faculty -OutFile faculty.html

Write-Host 'Success for faculty.html!' -ForegroundColor Green

wget https://www.westbrookctschools.org/groups/5743 -OutFile athletics.html

Write-Host 'Success for athletics.html!' -ForegroundColor Green

wget https://www.westbrookctschools.org/groups/5661 -OutFile business_office.html

Write-Host 'Success for business_office.html!' -ForegroundColor Green

wget https://www.westbrookctschools.org/groups/5663 -OutFile curriculum_and_instruction.html

Write-Host 'Success for curriculum_and_instruction.html!' -ForegroundColor Green

wget https://www.westbrookctschools.org/groups/5756 -OutFile food_services.html

Write-Host 'Success for food_services.html!' -ForegroundColor Green

wget https://www.westbrookctschools.org/groups/73867 -OutFile health.html

Write-Host 'Success for health.html!' -ForegroundColor Green

wget https://www.westbrookctschools.org/groups/5754 -OutFile human_resources.html

Write-Host 'Success for human_resources.html!' -ForegroundColor Green

Move-Item -Path powershell_yes.txt -Destination .\desktop\html_webpages

}

get_html 