# Create a new process object that starts PowerShell
$newProcess = New-Object System.Diagnostics.ProcessStartInfo "powershell";
# Indicate that the process should be elevated
$newProcess.Verb = "runas";
# Start the new process
[System.Diagnostics.Process]::Start($newProcess) | Out-Null

#UserName to Join with
$user = "YOUR USER HERE";
#Password to Join, ConvertTo_SecureString will make PS happy about passing it to Add-Computer, note that pass is in plain text here 0_o 
$pass = ConvertTo-SecureString "YOUR PASS HERE" -AsPlainText -Force;
#Create a new object to hold creds
$DomainCred = New-Object System.Management.Automation.PSCredential GACL\$user, $pass;
#Add that machine!
Add-Computer -domainname YOUR DOMAIN NAME -credential $DomainCred