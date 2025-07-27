# 確実なGitプッシュスクリプト
# Reliable Git Push Script for Cursor PowerShell

param(
    [string]$CommitMessage = "",
    [switch]$Force = $false
)

Write-Host "🔄 確実なGitプッシュを開始..." -ForegroundColor Green

# 現在の作業ディレクトリを確認
$currentDir = Get-Location
Write-Host "📁 作業ディレクトリ: $currentDir" -ForegroundColor Cyan

# 変更があるかチェック
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "📝 変更されたファイル:" -ForegroundColor Yellow
    git status --short
    
    # コミットメッセージが指定されていない場合はデフォルトを使用
    if ([string]::IsNullOrEmpty($CommitMessage)) {
        $CommitMessage = "Auto-commit: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }
    
    Write-Host "➕ ファイルをステージング..." -ForegroundColor Yellow
    git add -A
    
    Write-Host "💾 コミット実行..." -ForegroundColor Yellow
    git commit -m $CommitMessage
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ コミットに失敗しました" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✅ 変更なし - コミットをスキップ" -ForegroundColor Green
}

# リモートとの差分をチェック
Write-Host "🔍 リモートとの差分をチェック..." -ForegroundColor Cyan
$localCommit = git rev-parse HEAD
$remoteCommit = git ls-remote origin main | ForEach-Object { $_.Split()[0] }

Write-Host "📍 ローカル: $localCommit" -ForegroundColor Blue
Write-Host "📍 リモート: $remoteCommit" -ForegroundColor Blue

if ($localCommit -eq $remoteCommit) {
    Write-Host "✅ ローカルとリモートは既に同期済みです" -ForegroundColor Green
    exit 0
}

# プッシュ実行
Write-Host "🚀 プッシュを実行..." -ForegroundColor Yellow

$pushResult = $null
$attempts = 0
$maxAttempts = 3

do {
    $attempts++
    Write-Host "📤 プッシュ試行 $attempts/$maxAttempts..." -ForegroundColor Cyan
    
    # プッシュを実行し、結果をキャプチャ
    $pushOutput = git push origin main 2>&1
    $pushExitCode = $LASTEXITCODE
    
    if ($pushExitCode -eq 0) {
        Write-Host "✅ プッシュ成功!" -ForegroundColor Green
        Write-Host "📤 プッシュ結果:" -ForegroundColor Gray
        $pushOutput | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
        $pushResult = "success"
        break
    } else {
        Write-Host "⚠️ プッシュ試行 $attempts 失敗" -ForegroundColor Yellow
        Write-Host "📝 エラー出力:" -ForegroundColor Red
        $pushOutput | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        
        if ($attempts -lt $maxAttempts) {
            Write-Host "⏳ 2秒待機してリトライ..." -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        }
    }
} while ($attempts -lt $maxAttempts)

# 最終確認
if ($pushResult -eq "success") {
    Write-Host "🔍 最終確認..." -ForegroundColor Cyan
    $finalRemoteCommit = git ls-remote origin main | ForEach-Object { $_.Split()[0] }
    
    if ($localCommit -eq $finalRemoteCommit) {
        Write-Host "✅ プッシュ完了 - ローカルとリモートが同期されました!" -ForegroundColor Green
        Write-Host "🎯 最新コミット: $localCommit" -ForegroundColor Blue
    } else {
        Write-Host "⚠️ 警告: プッシュは成功しましたが、同期確認に失敗" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ プッシュに失敗しました ($maxAttempts 回試行)" -ForegroundColor Red
    Write-Host "🔧 手動でプッシュを実行してください:" -ForegroundColor Yellow
    Write-Host "   git push origin main" -ForegroundColor White
    exit 1
}

Write-Host "✨ 処理完了!" -ForegroundColor Green 