# Git Push Verification Script
# Verifies that push operations completed successfully

Write-Host "=== Git Push Verification ===" -ForegroundColor Green

# Get current directory
$currentDir = Get-Location
Write-Host "Directory: $currentDir" -ForegroundColor Cyan

# Get local commit info
Write-Host "`n📍 Local Repository Status:" -ForegroundColor Yellow
$localCommit = git rev-parse HEAD
$localCommitShort = git rev-parse --short HEAD
$localBranch = git branch --show-current
$localCommitMsg = git log -1 --pretty=format:"%s"
$localCommitDate = git log -1 --pretty=format:"%ci"

Write-Host "  Branch: $localBranch" -ForegroundColor White
Write-Host "  Commit: $localCommitShort ($localCommit)" -ForegroundColor White
Write-Host "  Message: $localCommitMsg" -ForegroundColor White
Write-Host "  Date: $localCommitDate" -ForegroundColor White

# Get remote commit info
Write-Host "`n🌐 Remote Repository Status:" -ForegroundColor Yellow
try {
    $remoteInfo = git ls-remote origin main 2>&1
    if ($LASTEXITCODE -eq 0) {
        $remoteCommit = $remoteInfo | ForEach-Object { $_.Split()[0] }
        $remoteCommitShort = $remoteCommit.Substring(0, 7)
        Write-Host "  Branch: main" -ForegroundColor White
        Write-Host "  Commit: $remoteCommitShort ($remoteCommit)" -ForegroundColor White
    } else {
        Write-Host "  ERROR: Cannot access remote repository" -ForegroundColor Red
        Write-Host "  $remoteInfo" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "  ERROR: Failed to check remote repository" -ForegroundColor Red
    Write-Host "  $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Compare local and remote
Write-Host "`n🔍 Synchronization Check:" -ForegroundColor Yellow
if ($localCommit -eq $remoteCommit) {
    Write-Host "  ✅ SUCCESS: Local and remote are synchronized!" -ForegroundColor Green
    Write-Host "  📊 Both repositories are at commit: $localCommitShort" -ForegroundColor Green
    $syncStatus = "SYNCHRONIZED"
} else {
    Write-Host "  ❌ WARNING: Local and remote are NOT synchronized!" -ForegroundColor Red
    Write-Host "  📍 Local:  $localCommitShort" -ForegroundColor Blue
    Write-Host "  🌐 Remote: $remoteCommitShort" -ForegroundColor Blue
    $syncStatus = "NOT_SYNCHRONIZED"
}

# Check for unpushed commits
Write-Host "`n📤 Unpushed Commits Check:" -ForegroundColor Yellow
$unpushedCommits = git log origin/main..HEAD --oneline 2>&1
if ($LASTEXITCODE -eq 0 -and $unpushedCommits) {
    Write-Host "  ⚠️ Found unpushed commits:" -ForegroundColor Yellow
    $unpushedCommits | ForEach-Object { Write-Host "    $_" -ForegroundColor White }
} elseif ($LASTEXITCODE -eq 0) {
    Write-Host "  ✅ No unpushed commits found" -ForegroundColor Green
} else {
    Write-Host "  ⚠️ Could not check unpushed commits" -ForegroundColor Yellow
}

# Check working directory status
Write-Host "`n📁 Working Directory Status:" -ForegroundColor Yellow
$workingStatus = git status --porcelain
if ($workingStatus) {
    Write-Host "  ⚠️ Uncommitted changes detected:" -ForegroundColor Yellow
    git status --short | ForEach-Object { Write-Host "    $_" -ForegroundColor White }
} else {
    Write-Host "  ✅ Working directory is clean" -ForegroundColor Green
}

# GitHub Actions check (if applicable)
Write-Host "`n🔧 GitHub Actions Status:" -ForegroundColor Yellow
try {
    # Try to get the latest workflow run status (requires gh CLI or API)
    Write-Host "  📝 Latest commit should trigger ZMK firmware build" -ForegroundColor Cyan
    Write-Host "  🔗 Check build status at: https://github.com/fjdayo/zmk-config-roBa/actions" -ForegroundColor Cyan
} catch {
    Write-Host "  ℹ️ Manual check recommended for GitHub Actions" -ForegroundColor Blue
}

# Final summary
Write-Host "`n=== VERIFICATION SUMMARY ===" -ForegroundColor Green
Write-Host "📊 Sync Status: $syncStatus" -ForegroundColor $(if($syncStatus -eq "SYNCHRONIZED") {"Green"} else {"Red"})
Write-Host "📍 Latest Commit: $localCommitShort - $localCommitMsg" -ForegroundColor Blue
Write-Host "🕒 Commit Time: $localCommitDate" -ForegroundColor Blue

if ($syncStatus -eq "SYNCHRONIZED") {
    Write-Host "`n🎉 PUSH VERIFICATION SUCCESSFUL!" -ForegroundColor Green
    Write-Host "   Your changes are now live on GitHub" -ForegroundColor Green
    Write-Host "   ZMK firmware build should start automatically" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n⚠️ PUSH VERIFICATION FAILED!" -ForegroundColor Red
    Write-Host "   Manual push may be required:" -ForegroundColor Yellow
    Write-Host "   git push origin main" -ForegroundColor White
    exit 1
} 