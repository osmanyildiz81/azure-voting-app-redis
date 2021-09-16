$count = 0
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
do {
    $count++
    Write-Output "[$env:STAGE_NAME] Starting container [Attempt: $count]"
    
    $testStart = Invoke-WebRequest -Uri http://localhost:8000 -UseBasicParsing
    
    if ($testStart.statuscode -eq '200') {
        $started = $true
    } else {
        Start-Sleep -Seconds 1
    }
    
} until ($started -or ($count -eq 300))

if (!$started) {
    exit 1
}