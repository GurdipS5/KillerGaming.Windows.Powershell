<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.197
	 Created on:   	29/03/2022 00:25
	 Created by:   	Administrator
	 Organization: 	
	 Filename:     	Set-WebServer.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>



Set-PSRepository -Name "myInternalSource" -SourceLocation 'https://someNuGetUrl.com/api/v2' -PublishLocation 'https://someNuGetUrl.com/api/v2/packages'

Clear-RecycleBin -DriveLetter C -Force