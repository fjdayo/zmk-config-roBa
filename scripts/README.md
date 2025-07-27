# Scripts Directory

## Git Push Scripts

### reliable-push.ps1
確実なGitプッシュを実行するスクリプトです。

**機能:**
- 変更の自動検知とコミット
- リトライ機能付きプッシュ（最大3回）
- リモートとの同期確認
- 詳細なステータス表示

**使用方法:**
```powershell
# 基本実行（自動コミットメッセージ）
PowerShell -ExecutionPolicy Bypass -File "scripts\reliable-push.ps1"

# カスタムコミットメッセージ指定
PowerShell -ExecutionPolicy Bypass -File "scripts\reliable-push.ps1" -CommitMessage "Your commit message"
```

### push.ps1
簡単なプッシュエイリアスです。

**使用方法:**
```powershell
# 基本実行
PowerShell -ExecutionPolicy Bypass -File "scripts\push.ps1"

# コミットメッセージ指定
PowerShell -ExecutionPolicy Bypass -File "scripts\push.ps1" -Message "Your commit message"
```

## PowerShell問題解決スクリプト

### fix-powershell-hanging.ps1
Cursorでコマンドが途中で止まる問題を解決します。

**使用方法:**
```powershell
PowerShell -ExecutionPolicy Bypass -File "scripts\fix-powershell-hanging.ps1"
```

### update-docs.ps1
ドキュメントの自動更新を行います。

**使用方法:**
```powershell
PowerShell -ExecutionPolicy Bypass -File "scripts\update-docs.ps1"
```

## 推奨使用方法

1. **通常のプッシュ**: `scripts\push.ps1` を使用
2. **問題が発生した場合**: `scripts\reliable-push.ps1` を直接実行
3. **PowerShell問題**: `scripts\fix-powershell-hanging.ps1` を実行 