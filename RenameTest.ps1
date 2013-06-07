$macAddress = (gwmi Win32_NetworkAdapterConfiguration | ?{$_.DNSDomain -eq 'uark.edu'}).MacAddress 			#get mac for current machine

Get-Content C:\Users\admin\Desktop\renametest.csv | Foreach {												#check each csv file entry
	$name,$mac = -split $_																					#split the entry into "name" and "mac"
	if ($mac -eq $macaddress){																				#find the corresponding entry
		Rename-Computer -NewName $name																		#and rename the computer 	
		}
}