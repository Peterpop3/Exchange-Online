#Script to get last logon time for specific users imported from CSV
#Working with O365 and Exchange Online

$users = Import-Csv .\Users.csv | foreach {get-mailbox -identity $_.User}
$userarray = @()
foreach ($user in $users)
{
$MailUser = $user.UserPrincipalName
$stats= Get-MailboxStatistics $MailUser
$datetime = $stats.LastUserActionTime
$date, $time = $datetime -split(' ')
$Maildetails = New-Object -TypeName PSObject -Property @{
DisplayName = $stats.DisplayName
#ItemCount = $stats.ItemCount
#MailboxSize = $stats.TotalItemSize
LastLogonDate = $date
LastLogonTime = $time
Email = $MailUser

}

$userarray += $Maildetails
} 

$userarray | Export-Csv .\Users1.csv