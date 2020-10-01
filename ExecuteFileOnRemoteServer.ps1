 param (
    [Parameter(Mandatory=$true)][string]$server = $( Read-Host "Input server address." ),
    [Parameter(Mandatory=$true)][string]$username = $( Read-Host "Input username." ),
    [Parameter(Mandatory=$true)][string]$password = $( Read-Host "Input password." ),
    [Parameter(Mandatory=$true)][String]$filePath = $( Read-Host "Input the fullpath to save the file." ),    
    [Parameter(HelpMessage="Additional paramters to pass to the executable")][String]$parameters 
 )

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

 Invoke-Command -ComputerName $server -Credential $credentials -ArgumentList ($filePath, $parameters)  -ScriptBlock {
    param($filePath, $parameters) 
    Write-Host "Executing $filePath $parameters"
    start-process -filepath $filePath -argumentlist $parameters
    Write-Host "Complete"
}