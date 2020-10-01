 param (
    [Parameter(Mandatory=$true)][string]$server = $( Read-Host "Input server address." ),
    [Parameter(Mandatory=$true)][string]$username = $( Read-Host "Input username." ),
    [Parameter(Mandatory=$true)][string]$password = $( Read-Host "Input password." ),
    [Parameter(Mandatory=$true)][string]$url = $( Read-Host "Url of the file to download." ),
    [Parameter(Mandatory=$true)][String]$serverPath = $( Read-Host "Input the fullpath to save the file." )
 )

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

 Invoke-Command -ComputerName $server -Credential $credentials -ArgumentList ($url, $serverPath)  -ScriptBlock {
    param($source, $destination) 
    $BitsTransferExists = Get-Module -ListAvailable -Name BitsTransfer
    if($BitsTransferExists ){
    	Write-Host "BitsTransfer is already installed"
    } else {
    	Write-Host "Installing BitsTransfer"
    	Import-Module -Name BitsTransfer -Scope Local -Force
    }
    $directory = Split-Path -Path $destination
    $directoryExists = Test-Path -Path $directory 
    if($directoryExists){
    	Write-Host "$directory already exists"
    } else {
    	Write-Host "Creating $directory"
        New-Item -Path $directory -ItemType "directory"
    }

    $start_time = Get-Date
    Start-BitsTransfer -Source $source -Destination $destination
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
}