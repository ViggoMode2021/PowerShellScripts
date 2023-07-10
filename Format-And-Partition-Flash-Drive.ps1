# Clear-Disk -Number “1” -RemoveData

# 1 mb (megabyte) = 1000 kb (kilobyte)
# 1 gb (gigabyte) = 1000 mb (megabyte)

<#
$Dir = Get-ChildItem C:\Users\ryans\LMS_WITH_LOGIN #-Recurse

$List = $Dir | where {$_.extension -eq ".py"}
#>

<#
$Drives = [System.IO.DriveInfo]::GetDrives()
$Removable_Drives = $Drives | Where-Object { $_.DriveType -eq 'Removable' -and $_.IsReady }
if($Removable_Drives){
    Write-Host $Removable_Drives
    $Continue_Prompt = Read-Host "Would you like to continue with the script? Press 1 for yes and 2 for no."
    if($Continue_Prompt -eq "1"){
    Setup_Flash_Drive
    }
}
throw "No removable drives found."
#>

diskmgmt.msc

# Name 1st partition

function Setup_Flash_Drive{

do{

$Partition_1_Name = Read-Host "What would you like to name the first partition?"

}

until($Partition_1_Name.Length -gt 1 -and -not $Partition_1_Name.StartsWith("\d"))
 
New-Partition -DiskNumber 1 -UseMaximumSize | Format-Volume -Filesystem NTFS -NewFileSystemLabel $Partition_1_Name

Write-Host "$Partition_1_Name has been set as the name for Partition 1." -ForeGroundColor "Green"

# Allocate 1st partition letter

do{

$Partition_1_Letter = Read-Host "What drive letter would you like to give the first partition (besides 'C')"

}

until($Partition_1_Letter.Length -eq 1 -and $Partition_1_Letter -notmatch "\d")

Write-Host "$Partition_1_Letter has been set as the drive letter for Partition 1." -ForeGroundColor "Green"

$Partition_1_Destination = "$Partition_1_Letter" + ":\"

Write-Host $Partition_1_Destination

Get-Partition -DiskNumber 1 | Set-Partition -NewDriveLetter $Partition_1_Letter

Resize-Partition -DiskNumber 1 -PartitionNumber 1 -Size (10000MB)

# Name 2nd partition

do{

$Partition_2_Name = Read-Host "What would you like to name the second partition?"

}

until($Partition_2_Name.Length -gt 1 -and -not $Partition_2_Name.StartsWith("\d"))

Write-Host "$Partition_2_Name has been set as the name for Partition 1." -ForeGroundColor "Green"

# Allocate 2nd partition letter

do{

$Partition_2_Letter = Read-Host "What drive letter would you like to give the second partition (besides 'C')"

}

until($Partition_2_Letter.Length -eq 1 -and $Partition_2_Letter -notmatch "\d")

Write-Host "$Partition_2_Letter has been set as the drive letter for Partition 2." -ForeGroundColor "Green"

New-Partition -DiskNumber 1 -UseMaximumSize | Format-Volume -Filesystem NTFS -NewFileSystemLabel $Partition_2_Name

Get-Partition -DiskNumber 1 | Set-Partition -NewDriveLetter $Partition_2_Letter

Resize-Partition -DiskNumber 1 -PartitionNumber 2 -Size (3000MB)

$Partition_1_Destination = "$Partition_1_Letter" + ":\"

$Partition_2_Destination = "$Partition_2_Letter" + ":\"

Copy-Item -Path C:\Users\rviglione\Desktop\Python -Filter *.py -Destination $Partition_1_Destination -Recurse

Copy-Item -Path C:\Users\rviglione\Desktop\Scripts -Filter *.ps1 -Destination $Partition_2_Destination -Recurse

$driveEject = New-Object -comObject Shell.Application
$driveEject.Namespace(17).ParseName($Partition_1_Destination).InvokeVerb("Eject")

}

Setup_Flash_Drive
