# Define the exact process names you want to check (e.g., 'notepad.exe' and 'calc.exe')
$processNames = @("wsjtx.exe", "jt9.exe")
$processesKilled = $false
$exeToStart = "C:\WSJT\wsjtx\bin\wsjtx.exe" # Change this to the path of the executable you want to start

foreach ($processName in $processNames) {
    # Get the process by name, stripping off the '.exe' extension for comparison
    $process = Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq ($processName -replace '\.exe$', '') }
    
    if ($process) {
        # If the process is running, kill it
        Stop-Process -Id $process.Id -Force
        Write-Output "The process $processName was running and has been killed."
        $processesKilled = $true
    }
}

if ($processesKilled) {
    # If any of the processes were killed, display a message and wait
    Write-Output "Hold your horses"
    Start-Sleep -Seconds 5
    Write-Output "Here you go"
    
    # Start the specific process
    Start-Process $exeToStart
}