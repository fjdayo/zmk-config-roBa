# PowerShell Command Hanging Fix Script for Cursor
# Fixes issues where PowerShell commands stop and require "back to background"

Write-Host "Applying PowerShell command hanging fixes..." -ForegroundColor Green

# 1. Disable Git pager to prevent commands from stopping
Write-Host "Disabling Git pager..." -ForegroundColor Yellow
git config --global core.pager "cat"

# 2. Configure PowerShell output buffering
Write-Host "Configuring PowerShell output settings..." -ForegroundColor Yellow
$PSDefaultParameterValues['Out-Default:OutVariable'] = 'LastOutput'

# 3. Disable progress bar (prevents display issues)
Write-Host "Disabling progress bar display..." -ForegroundColor Yellow
$ProgressPreference = 'SilentlyContinue'

# 4. Set error action to continue
Write-Host "Adjusting error handling..." -ForegroundColor Yellow
$ErrorActionPreference = 'Continue'

# 5. Add settings to PowerShell profile for persistence
$ProfilePath = $PROFILE.CurrentUserCurrentHost
$ProfileDir = Split-Path $ProfilePath -Parent

if (!(Test-Path $ProfileDir)) {
    New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
}

$ConfigContent = @"
# Cursor PowerShell Settings - Command Hanging Fix
`$PSDefaultParameterValues['Out-Default:OutVariable'] = 'LastOutput'
`$ProgressPreference = 'SilentlyContinue'
`$ErrorActionPreference = 'Continue'

# Git Settings
`$env:GIT_PAGER = 'cat'
"@

if (!(Test-Path $ProfilePath)) {
    Write-Host "Creating PowerShell profile..." -ForegroundColor Yellow
    New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
}

# Check existing content to avoid duplicates
$ExistingContent = Get-Content $ProfilePath -Raw -ErrorAction SilentlyContinue
if ($ExistingContent -notmatch "Cursor PowerShell Settings") {
    Write-Host "Adding persistent settings to profile..." -ForegroundColor Yellow
    Add-Content -Path $ProfilePath -Value "`n$ConfigContent"
}

Write-Host "`nPowerShell command hanging fix completed!" -ForegroundColor Green
Write-Host "Settings will auto-apply on next PowerShell startup." -ForegroundColor Cyan

Write-Host "`nApplied settings:" -ForegroundColor Blue
Write-Host "- Git pager disabled (core.pager = cat)" -ForegroundColor White
Write-Host "- Output buffering adjusted" -ForegroundColor White
Write-Host "- Progress bar hidden" -ForegroundColor White
Write-Host "- Error handling set to continue" -ForegroundColor White

Write-Host "`nTo apply settings immediately:" -ForegroundColor Blue
Write-Host ". `$PROFILE" -ForegroundColor Yellow 