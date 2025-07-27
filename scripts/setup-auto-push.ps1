# Setup Auto-Push for roBa Keyboard Configuration
# Creates Git hooks for automatic documentation updates and pushing

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$HooksDir = Join-Path $ProjectRoot ".git\hooks"
$PreCommitHook = Join-Path $HooksDir "pre-commit"

Write-Host "roBa キーボード 自動プッシュ設定スクリプト" -ForegroundColor Green

# Create pre-commit hook
$hookContent = @"
#!/bin/sh
# Pre-commit hook for automatic documentation update

# Check if config files are being committed
if git diff --cached --name-only | grep -E "(config/.*\.(keymap|json|overlay|dtsi))" > /dev/null; then
    echo "設定ファイルの変更を検出しました。ドキュメントを自動更新中..."
    
    # Run documentation update script
    powershell.exe -ExecutionPolicy Bypass -File "scripts/update-docs.ps1" -AutoPush
    
    # Add updated documentation to commit
    git add docs/roBa-keyboard-settings.md
    
    echo "ドキュメント自動更新完了。"
fi
"@

# Ensure hooks directory exists
if (-not (Test-Path $HooksDir)) {
    New-Item -ItemType Directory -Path $HooksDir -Force
    Write-Host "Hooksディレクトリを作成しました: $HooksDir" -ForegroundColor Yellow
}

# Create pre-commit hook
$hookContent | Out-File $PreCommitHook -Encoding UTF8
Write-Host "Pre-commitフックを作成しました: $PreCommitHook" -ForegroundColor Green

# Make hook executable (on Windows with Git Bash)
try {
    if (Get-Command "bash" -ErrorAction SilentlyContinue) {
        bash -c "chmod +x '$($PreCommitHook -replace '\\', '/')'"
        Write-Host "フックを実行可能にしました。" -ForegroundColor Green
    }
}
catch {
    Write-Warning "フックの実行権限設定に失敗しました。Git Bashで手動設定が必要な場合があります。"
}

# Create post-commit hook for auto-push
$postCommitHook = Join-Path $HooksDir "post-commit"
$postCommitContent = @"
#!/bin/sh
# Post-commit hook for automatic pushing

# Check if documentation was updated
if git diff --name-only HEAD^ HEAD | grep "docs/roBa-keyboard-settings.md" > /dev/null; then
    echo "ドキュメントが更新されました。GitHubにプッシュ中..."
    
    # Auto-push to origin
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo "プッシュが完了しました。"
    else
        echo "プッシュに失敗しました。手動でプッシュしてください。"
    fi
fi
"@

$postCommitContent | Out-File $postCommitHook -Encoding UTF8
Write-Host "Post-commitフックを作成しました: $postCommitHook" -ForegroundColor Green

# Make post-commit hook executable
try {
    if (Get-Command "bash" -ErrorAction SilentlyContinue) {
        bash -c "chmod +x '$($postCommitHook -replace '\\', '/')'"
        Write-Host "Post-commitフックを実行可能にしました。" -ForegroundColor Green
    }
}
catch {
    Write-Warning "Post-commitフックの実行権限設定に失敗しました。"
}

Write-Host "`n=== 設定完了 ===" -ForegroundColor Cyan
Write-Host "設定ファイルをコミットすると、自動的に:" -ForegroundColor White
Write-Host "1. ドキュメントが更新されます" -ForegroundColor White
Write-Host "2. 変更がGitHubにプッシュされます" -ForegroundColor White
Write-Host "`n注意: 初回はGitHub認証情報の入力が必要な場合があります。" -ForegroundColor Yellow 