<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.197
	 Created on:   	29/03/2022 23:37
	 Created by:   	Administrator
	 Organization: 	
	 Filename:     	Set-Chocolatey.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>





$testchoco = powershell choco -v
if (-not ($testchoco))
{
	Write-Output "Seems Chocolatey is not installed, installing now"
	Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else
{
	Write-Output "Chocolatey Version $testchoco is already installed"
}

# or

if (test-path "C:\ProgramData\chocolatey\choco.exe")
{
	
}