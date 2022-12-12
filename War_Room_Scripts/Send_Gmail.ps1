$Date = Get-Date

$mycredentials = Get-Credential
Send-MailMessage -SmtpServer smtp.gmail.com -Port 587 -UseSsl -From "youremailhere@gmail.com" -To "destinationemailhere@gmail.com" -Subject 'Test subject' -Body 'emailbodyhere' -Attachment "attachmenthere" -Credential $mycredentials
