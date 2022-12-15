#Start-Process Brave https://www.westbrookctschools.org/

# https://github.com/kamome283/AngleParse

#https://linuxhint.com/run-wget-powershell/

iwr "https://www.westbrookctschools.org/" | Select-HtmlContent "div.html-wrapper-inner", @{
    Title = "div.html-wrapper-inner > p"
    Author = "span.link-list-text > p"
} | select -first 2 | Format-List
   

$Response = Invoke-WebRequest -URI https://www.westbrookctschools.org/ -UseBasicParsing
$Response.InputFields | Where-Object {
    $_.name -like "* Value*"
} | Select-Object Name, Value

wget https://www.westbrookctschools.org/ -OutFile main_page.html
