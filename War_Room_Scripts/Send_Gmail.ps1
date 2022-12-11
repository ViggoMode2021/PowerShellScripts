$Date = Get-Date

$mycredentials = Get-Credential
Send-MailMessage -SmtpServer smtp.gmail.com -Port 587 -UseSsl -From "ryansviglione@gmail.com" -To "ryansviglione@gmail.com" -Subject 'Test subject' -Body '$Date' -Attachment "C:\Users\ryans\Desktop\de.jpg" -Credential $mycredentials
