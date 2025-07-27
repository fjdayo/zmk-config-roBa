# roBa キーボード設定

ZMKファームウェアを使用した分割型40%キーボードの設定リポジトリです。

## 特徴

- 40キー分割型レイアウト
- Seeeduino XIAO BLE使用
- 左手側エンコーダーによるマウススクロール機能
- 右手側トラックボール搭載
- 日本語キーボード環境対応

## ドキュメント

詳細な設定については `docs/roBa-keyboard-settings.md` をご覧ください。

### 自動ドキュメント更新

このプロジェクトには自動ドキュメント更新システムが組み込まれています：

- **Cursor Rules**: `.cursorrules` ファイルでエディター連動
- **PowerShell Script**: `scripts/update-docs.ps1` で手動実行

#### 使用方法
```powershell
# 手動でドキュメント更新
.\scripts\update-docs.ps1

# 特定のファイル変更を反映してコミット
.\scripts\update-docs.ps1 -ConfigFile "config\roBa.keymap"

# 自動プッシュ付きでコミット
.\scripts\update-docs.ps1 -ConfigFile "config\roBa.keymap" -AutoPush

# 強制更新（すべてのファイルを確認）
.\scripts\update-docs.ps1 -Force -AutoPush
```

---

最終更新: 2024年
