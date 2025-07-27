# Reliable Git Push Script for Cursor PowerShell
# Ensures Git push operations complete successfully

param(
    [string]$CommitMessage = "",
    [switch]$Force = $false
)

Write-Host "Starting reliable Git push..." -ForegroundColor Green

# Check current directory
$currentDir = Get-Location
Write-Host "Working directory: $currentDir" -ForegroundColor Cyan

# Check for changes
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "Changes detected:" -ForegroundColor Yellow
    git status --short
    
    # Use default commit message if not provided
    if ([string]::IsNullOrEmpty($CommitMessage)) {
        $CommitMessage = "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }
    
    Write-Host "Staging files..." -ForegroundColor Yellow
    git add -A
    
    Write-Host "Committing changes..." -ForegroundColor Yellow
    git commit -m $CommitMessage
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Commit failed" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "No changes detected - skipping commit" -ForegroundColor Green
}

# Check difference with remote
Write-Host "Checking remote differences..." -ForegroundColor Cyan
$localCommit = git rev-parse HEAD
$remoteCommit = git ls-remote origin main | ForEach-Object { $_.Split()[0] }

Write-Host "Local:  $localCommit" -ForegroundColor Blue
Write-Host "Remote: $remoteCommit" -ForegroundColor Blue

if ($localCommit -eq $remoteCommit) {
    Write-Host "SUCCESS: Local and remote are already in sync" -ForegroundColor Green
    exit 0
}

# Execute push with retry logic
Write-Host "Executing push..." -ForegroundColor Yellow

$pushResult = $null
$attempts = 0
$maxAttempts = 3

do {
    $attempts++
    Write-Host "Push attempt $attempts/$maxAttempts..." -ForegroundColor Cyan
    
    # Execute push and capture result
    $pushOutput = git push origin main 2>&1
    $pushExitCode = $LASTEXITCODE
    
    if ($pushExitCode -eq 0) {
        Write-Host "SUCCESS: Push completed!" -ForegroundColor Green
        Write-Host "Push output:" -ForegroundColor Gray
        $pushOutput | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
        $pushResult = "success"
        break
    } else {
        Write-Host "WARNING: Push attempt $attempts failed" -ForegroundColor Yellow
        Write-Host "Error output:" -ForegroundColor Red
        $pushOutput | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        
        if ($attempts -lt $maxAttempts) {
            Write-Host "Waiting 2 seconds before retry..." -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        }
    }
} while ($attempts -lt $maxAttempts)

# Final verification
if ($pushResult -eq "success") {
    Write-Host "Final verification..." -ForegroundColor Cyan
    $finalRemoteCommit = git ls-remote origin main | ForEach-Object { $_.Split()[0] }
    
    if ($localCommit -eq $finalRemoteCommit) {
        Write-Host "SUCCESS: Push verified - local and remote are synchronized!" -ForegroundColor Green
        Write-Host "Latest commit: $localCommit" -ForegroundColor Blue
    } else {
        Write-Host "WARNING: Push succeeded but verification failed" -ForegroundColor Yellow
    }
} else {
    Write-Host "ERROR: Push failed after $maxAttempts attempts" -ForegroundColor Red
    Write-Host "Manual push required:" -ForegroundColor Yellow
    Write-Host "   git push origin main" -ForegroundColor White
    exit 1
}

Write-Host "Process completed!" -ForegroundColor Green 