 param (
    [Parameter(Mandatory=$true)][string]$server = $( Read-Host "Input server address." ),
    [Parameter(Mandatory=$true)][string]$username = $( Read-Host "Input username." ),
    [Parameter(Mandatory=$true)][string]$password = $( Read-Host "Input password." ),
    [Parameter(Mandatory=$true)][string]$file = $( Read-Host "input full filepath." ),
    [string]$serverPath = '/',
    [int]$port = 22
 )

 $poshExists = Get-Module -ListAvailable -Name Posh-SSH
if($poshExists){
	Write-Host "Posh-SSH is already installed"
} else {
	Write-Host "Installing Posh-SSH"
	Install-Module -Name Posh-SSH -Scope CurrentUser -Force
}

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
$session = New-SFTPSession -ComputerName $server -Credential $credentials -AcceptKey -Port $port
Set-SFTPFile -SessionId ($session).SessionId -Localfile $file -RemotePath $serverPath  -Overwrite
Remove-SFTPSession -SessionId ($session).SessionId

