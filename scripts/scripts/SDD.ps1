<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.197
	 Created on:   	14/02/2022 21:26
	 Created by:   	Administrator
	 Organization: 	
	 Filename:     	Get-HypervHealth.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>



<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.197
	 Created on:   	28/01/2022 00:17
	 Created by:   	Administrator
	 Organization: 	
	 Filename:     	Get-HypervHealth.p1.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#foreach ($hypervHost in $hypervHosts)
#{
$myHashtable = @{
	Memory	     = ''
	CPU		     = ''
	Service	     = ''
	Storage	     = ''
	Connectivity = ''
}

$TestPath = Test-Path "\\GLOHYPERV01\c$"

	If ($TestPath -match "True")
{
		$myHashtable.Connectivity = 'Good'
		New-PSSession -ComputerName "GLOHYPERV01.GLOBAL.GSSIRA.COM" -Credential (Get-Credential)
	}

	else
	{
		$myHashtable.Connectivity = 'Degraded'
	}

 # Get free memory in %
 $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem -ComputerName "GLOHYPERV01"

 $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)


	
	# Check service status
	Get-Service vmcompute  -ComputerName GLOHYPERV01  | %{
		if ($_.Status -eq "Stopped")
		{
			$myHashtable.Service = 'Degraded'
		}
		
		elseif ($_.Status -eq 'Running')
		{
			$myHashtable.Service = 'Good'
		}
	}
	
 # get free disk space
 $vmPath = Get-VMHost | select VirtualHardDiskPath



 # Get free memory in %
 $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem -ComputerName "GLOHYPERV01"

 $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)


	if ($pctFree > 80)
	{
		$myHashtable.Memory = 'Degraded'
	}
		
#}