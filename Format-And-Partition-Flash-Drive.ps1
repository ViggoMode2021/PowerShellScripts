# Clear-Disk -Number “1” -RemoveData

# 1 mb (megabyte) = 1000 kb (kilobyte)
# 1 gb (gigabyte) = 1000 mb (megabyte)

$Dir = get-childitem C:\windows\system32 -recurse
# $Dir |get-member
$List = $Dir | where {$_.extension -eq ".dll"}
$List |ft fullname |out-file C:\Users\ryans\desktop\dll.txt
# List | format-table name

$Drives = [System.IO.DriveInfo]::GetDrives()
$Removable_Drives = $Drives | Where-Object { $_.DriveType -eq 'Removable' -and $_.IsReady }
if($Removable_Drives){
    return @($Removable_Drives)
}
throw "No removable drives found."

diskmgmt.msc

$Partition_1_Name = Read-Host "What would you like to name the first partition?"

New-Partition -DiskNumber 1 -UseMaximumSize | Format-Volume -Filesystem NTFS -NewFileSystemLabel $Partition_1_Name

Get-Partition -DiskNumber 1 | Set-Partition -NewDriveLetter P

Resize-Partition -DiskNumber 1 -PartitionNumber 1 -Size (10000MB)

$Partition_2_Name = Read-Host "What would you like to name the second partition?"

New-Partition -DiskNumber 1 -UseMaximumSize | Format-Volume -Filesystem NTFS -NewFileSystemLabel $Partition_2_Name

Get-Partition -DiskNumber 1 | Set-Partition -NewDriveLetter S

Resize-Partition -DiskNumber 1 -PartitionNumber 2 -Size (3000MB)
