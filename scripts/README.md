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

### verify-push.ps1
プッシュ完了の詳細確認を行います。

**機能:**
- ローカルとリモートの同期状況確認
- 未プッシュコミットの検出
- 作業ディレクトリの状態確認
- GitHub Actions ビルド状況の案内
- 詳細なステータスレポート

**使用方法:**
```powershell
# プッシュ確認実行
PowerShell -ExecutionPolicy Bypass -File "scripts\verify-push.ps1"
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
3. **プッシュ完了確認**: `scripts\verify-push.ps1` で詳細確認
4. **PowerShell問題**: `scripts\fix-powershell-hanging.ps1` を実行

## プッシュ確認の流れ

1. **変更作業完了**
2. **プッシュ実行**: `scripts\push.ps1 -Message "Your message"`
3. **自動確認**: reliable-push.ps1が自動でverify-push.ps1を実行
4. **結果確認**: 
   - ✅ SYNCHRONIZED: プッシュ成功
   - ❌ NOT_SYNCHRONIZED: 再プッシュが必要
   - 🔧 GitHub Actions でZMKビルド自動開始 