<#

PowerShellSmokeTesting

#>


$UrlListFilePath = ".\targets.txt"
$UrlList = Get-Content $UrlListFilePath -ErrorAction SilentlyContinue 

ForEach($Url in $UrlList)  
{ 
    $response =  try { 	
				Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 3 -ErrorAction Ignore 
	}catch [System.Net.WebException] {
		Write-Host "An exception was caught: $($_.Exception.Message)"
	}
    
    If($response.StatusCode -eq 200)
    {
        Write-Host $response.StatusCode - "I'm OK" - $Url -fore green
    }
    else
    {
        Write-Host StatusCode ($response.StatusCode) $Url -fore red
    }    
}