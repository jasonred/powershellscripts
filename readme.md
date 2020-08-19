# Jasonred Powershell Scripts
This repository is being used to store commonly used simple powershell scripts that I create or other processes. 

# sftpFileTransfer.ps1
This script transfers an file via sftp. It installs the Posh-SSH module if it doesn't exist and uses it to transfer a file to a desired sftp server location.

## usage:
```sh
.\sftpTransfter.ps1 [-server] <string> [-username] <string> [-password] <string> [-file] <string> [[-serverPath] <string>] [[-port] <int>] [<CommonParameters>]
```
