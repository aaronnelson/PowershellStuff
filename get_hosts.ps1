$archHosts = @{}																		#init empty array for hostnames

$archHosts = Get-ADComputer -SearchBase 'OU=School of Architecture,dc=uark,dc=edu' -Filter '*' | Select-Object -ExpandProperty Name 
#AD query returns array of hostnames only via Select-Object

$ipDict = New-Object 'System.Collections.Generic.SortedDictionary[string, string[]]'	#init Sorted Dictionary for ips and hosts

foreach ($i in $archHosts){																#loop though all hostnames
	$ErrorActionPreference = "SilentlyContinue"											#turning off errors for missing hosts
	
	$hostname = $i																		#current index is hostname

	$remotehostipv4 = [system.net.dns]::gethostaddresses($i)|?{$_.scopeid -eq $null}|%{$_.ipaddresstostring}	#dns query for ipv4 address (ipv4 address ScopeID is always NULL) and store as string

	foreach($i in $remotehostipv4){														#if more than one ipv4 address per hostname, query returns an array of these addresees
		if($i.StartsWith("130.184")){													#loop though and pick only the address matching the first two octets
			$ipDict["$i"] = "$hostname"													#and add the results to a Dictonary

		}
	}
}

foreach($i in $ipDict.GetEnumerator()){													#loop through Dictionary by index								
	$ip = $i.key																		#retireve ip and store
	$hostname = $i.value																#retrieve hostname ans store
	$hostname = $hostname.ToUpper()														#make all uppercase for pretty
	Add-Content c:\Users\aenelson\Desktop\newhosts.txt "$ip  $hostname.UARK.EDU"		#Adds entry to file and adds spacing and .UARK.EDU.  Change path here accordingly
	}
