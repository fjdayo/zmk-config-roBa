# Simple push alias - calls reliable-push.ps1
param(
    [string]$Message = ""
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$reliablePushScript = Join-Path $scriptDir "reliable-push.ps1"

if ([string]::IsNullOrEmpty($Message)) {
    & PowerShell -ExecutionPolicy Bypass -File $reliablePushScript
} else {
    & PowerShell -ExecutionPolicy Bypass -File $reliablePushScript -CommitMessage $Message
} 