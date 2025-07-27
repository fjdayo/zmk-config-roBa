# roBa キーボード設定ドキュメント

## 概要

roBaは分割型40%キーボードで、ZMKファームウェアを使用しています。日本語キーボード環境での使用を前提とした設定が施されており、複数のレイヤーとコンボキー機能を備えています。

## ハードウェア仕様

### 基本構成
- **キー数**: 40キー（左手側20キー、右手側20キー）
- **マイコン**: Seeeduino XIAO BLE
- **通信**: Bluetooth LE
- **レイアウト**: カラムスタッガード配列
- **エンコーダー**: 左右に1つずつ（現在無効化）

### 物理レイアウト
- 4行×10列（親指キー含む）
- カラムスタッガード配列
- 左右分割式
- 親指キーは角度調整済み

## ファームウェア設定

### レイヤー構成

#### レイヤー0: Default Layer（デフォルト）
基本的なアルファベット入力レイヤーです。

**特徴:**
- QWERTYベースの配列
- 日本語入力切替対応
- モディファイヤーキーとのコンビネーション

**主要キー配置:**
```
Q    W    E    R    T                Y    U    I    O    P
A    S    D    F    G    [SS]   [-]   H    J    K    L    '
Z    X    C    V    B    [:]    [;]   N    M    ,    .    /
Ctrl Win  Alt  [変換] [SP]  [無変換]  [BS] [ENT]           Del
```

**特殊機能:**
- `Q`: 長押しで半角/全角切替
- `P`: 長押しでBackspace
- `I`: レイヤー5（スクロール）への一時移行
- `変換`: レイヤー6への移行
- `無変換`: レイヤー3（矢印）への移行
- `SPACE`: レイヤー2（数字）への一時移行
- `ENTER`: レイヤー1（ファンクション）への一時移行

#### レイヤー1: FUNCTION（記号・特殊文字）
記号や特殊文字の入力に使用します。

**キー配置:**
```
    &    *    (    )                (    )                    
~   $    %    ^              {    }    ;    '    \
`   !    @    #              [    ]    :    "    |
                                                     
```

#### レイヤー2: NUM（数字・ファンクションキー）
数字入力とファンクションキーの層です。

**キー配置:**
```
     F7   F8   F9   F10              +    7    8    9    -
     F4   F5   F6   F11              *    4    5    6    /
ESC  F1   F2   F3   F12  F13    =    0    1    2    3    .
```

#### レイヤー3: ARROW（矢印・ナビゲーション）
カーソル移動とナビゲーション機能の層です。

**キー配置:**
```
BS   Ctrl+Shift+Tab  ↑   Ctrl+Tab    Del
Home      ←         ↓      →        End
Shift  Cmd+Shift+←  Shift+Tab  Cmd+Shift+→
```

#### レイヤー4: MOUSE（マウス機能）
マウス操作関連の機能層です。

**キー配置:**
```
                                    
                        左クリック  中クリック  右クリック  [無変換で戻る]
                                   Cmd+Tab
```

#### レイヤー5: SCROLL（スクロール）
スクロール機能用の層（現在は機能未実装）です。

#### レイヤー6: System/Bluetooth（システム・Bluetooth）
システム機能とBluetooth管理の層です。

**キー配置:**
```
            BT1  BT2  BT3  BT4  BT5
1    2    3              bootloader      BT Clear
                                         BT Clear All
```

### 日本語キーボード設定

OS設定を日本語キーボードのまま使用するための変換定義が設定されています：

| 記号 | 定義名 | ZMKキーコード | 説明 |
|------|--------|---------------|------|
| " | JP_DQUOTE | AT | ダブルクォート |
| & | JP_AMPERSAND | CARET | アンパサンド |
| ' | JP_QUOTE | AMPERSAND | シングルクォート |
| = | JP_EQUAL | UNDER | イコール |
| ^ | JP_CARET | EQUAL | ハット |
| ¥ | JP_YEN | 0x89 | 円記号 |
| + | JP_PLUS | COLON | プラス |
| ~ | JP_TILDE | PLUS | チルダ |
| \| | JP_PIPE | LS(0x89) | パイプ |
| @ | JP_AT | LEFT_BRACKET | アットマーク |
| : | JP_COLON | SINGLE_QUOTE | コロン |
| * | JP_ASTERISK | DOUBLE_QUOTES | アスタリスク |
| ` | JP_BACKQUOTE | LEFT_BRACE | バッククォート |
| _ | JP_UNDERSCORE | LS(0x87) | アンダースコア |
| [ | JP_LBRACKET | RIGHT_BRACKET | 左角括弧 |
| ] | JP_RBRACKET | BACKSLASH | 右角括弧 |
| ( | JP_LPAREN | ASTERISK | 左丸括弧 |
| ) | JP_RPAREN | LEFT_PARENTHESIS | 右丸括弧 |
| { | JP_LBRACE | RIGHT_BRACE | 左波括弧 |
| } | JP_RBRACE | PIPE | 右波括弧 |
| かな | JP_KANA | LANGUAGE_1 | かな入力 |
| 英数 | JP_EISU | LANGUAGE_2 | 英数入力 |
| 半角/全角 | JP_HANZEN | GRAVE | 半角全角切替 |

### コンボキー設定

複数のキーを同時押しすることで特定の機能を実行できます：

| キー位置 | 機能 | 説明 |
|----------|------|------|
| 11 + 12 | Tab | タブキー |
| 12 + 13 | Shift + Tab | 逆タブ |
| 10 + 11 | 無変換 | 無変換キー（レイヤー0に戻る） |
| 20 + 21 | " | ダブルクォート |
| 24 + 25 | = | イコール |

### カスタムビヘイビア

#### `lt_to_layer_0`
- ホールド: 指定レイヤーへの一時移行
- タップ: レイヤー0への移行 + 指定キーの送信
- タッピング時間: 200ms

#### `to_layer_0` マクロ
- レイヤー0への移行とキー送信を組み合わせたマクロ
- 1パラメータのマクロ機能

#### `&mt` 設定
- フレーバー: "balanced"
- クイックタップ: 0ms

## Bluetooth設定

### ペアリング
- レイヤー6でBT1〜BT5キーを使用
- 最大5台のデバイスとペアリング可能

### 管理機能
- **BT Clear**: 選択したプロファイルのペアリング情報削除
- **BT Clear All**: 全てのペアリング情報削除
- **bootloader**: ブートローダーモードへの移行

## ファイル構成

### メイン設定ファイル
- `config/roBa.keymap`: キーマップ定義
- `config/roBa.json`: レイアウト情報
- `build.yaml`: ビルド設定

### ハードウェア定義
- `config/boards/shields/roBa.dtsi`: ハードウェア定義
- `config/boards/shields/roBa_L.overlay`: 左手側設定
- `config/boards/shields/roBa_R.overlay`: 右手側設定
- `config/boards/shields/roBa_L.conf`: 左手側コンフィグ
- `config/boards/shields/roBa_R.conf`: 右手側コンフィグ
- `config/boards/shields/roBa.zmk.yml`: ZMK設定

### Kconfig設定
- `config/boards/shields/Kconfig.shield`: シールド定義
- `config/boards/shields/Kconfig.defconfig`: デフォルト設定

## 使用上の注意

### 日本語入力
- OS側のキーボード設定は「日本語キーボード」のまま使用
- ファームウェア側で適切な変換が行われます

### レイヤー切替
- レイヤー切替は主に親指キーで行います
- 一時的な切替（Layer Tap）と永続的な切替の組み合わせ

### Bluetooth接続
- 初回ペアリング時は該当するBTキーを長押し
- 接続トラブル時はBT Clearを使用

## カスタマイズ

### キーマップの変更
1. `config/roBa.keymap`を編集
2. 必要に応じて日本語変換定義を追加
3. コミット後、自動ビルドが実行されます

### レイヤーの追加
1. 新しいレイヤー番号を定義
2. `keymap`セクションに追加
3. 必要に応じてアクセス方法を設定

このドキュメントは設定の変更に伴って更新されます。 