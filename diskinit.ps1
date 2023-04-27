# Set CD/DVD Drive to Z:
$cdrom = (Get-WmiObject -Class Win32_volume -Filter 'DriveType=5')
 
if ($cdrom.DriveType -eq 5){
    $cdrom | Select-Object -First 1 | Set-WmiInstance -Arguments @{DriveLetter='Z:'}
    Write-Output "Changed CD Drive letter from Z:"
}
else{
    Write-Output "CD Drive not present"
}
 
# Initialise Disks (in order) From E:\
$disks = Get-Disk | Where-Object partitionstyle -eq 'raw' | Sort-Object -Property Number 
 
foreach ($disk in $disks){
    $drive = [char](68 + $disk.disknumber)  #[CHAR]68 = D
    $diskid = $disk.disknumber
    Initialize-Disk -PartitionStyle GPT -PassThru -Number $disk.disknumber 
    New-Partition -DiskNumber $diskid -DriveLetter $drive -UseMaximumSize
    if ($diskid -eq 1){
        Format-Volume -FileSystem NTFS -Confirm:$false -NewFileSystemLabel 'Data' -DriveLetter $drive
    }
    #Set 64k Allocation for SQL Drives 
    else{
        Format-Volume -FileSystem NTFS -AllocationUnitSize 65536 -Confirm:$false -NewFileSystemLabel 'Data' -DriveLetter $drive
    }
}
