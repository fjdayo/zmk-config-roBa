# roBa キーボード設定ドキュメント

## 概要

roBaは分割型40%キーボードで、ZMKファームウェアを使用しています。日本語キーボード環境での使用を前提とした設定が施されており、複数のレイヤーとコンボキー機能を備えています。

## ハードウェア仕様

### 基本構成
- **キー数**: 40キー（左手側20キー、右手側20キー）
- **マイコン**: Seeeduino XIAO BLE
- **通信**: Bluetooth LE
- **レイアウト**: カラムスタッガード配列
- **エンコーダー**: 左手側にマウススクロール用エンコーダー
- **トラックボール**: 右手側にPixArt PMW3610搭載

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

**詳細キー配置:**
```
行1: ESC/Q    W         E         R         T                              Y         U         I         O         BS/P
行2: A        S         D         F         G         [SS]        [-]       H         J         K         L         '
行3: Shift/Z  X         C         V         B         [:]         [;]       N         M         ,         .5/       /
行4: Ctrl     Win       Alt       変換/6    Space/2   無変換/3             BS        Enter/1                       Del
```

**キー詳細説明:**
- **Q**: タップで`Q`、長押しで`ESC`（`mt ESCAPE Q`）
- **P**: タップで`P`、長押しで`BACKSPACE`（`mt BACKSPACE P`）
- **Z**: タップで`Z`、長押しで`LEFT_SHIFT`（`mt LEFT_SHIFT Z`）
- **L**: タップで`L`、長押しでレイヤー4（マウス）への一時移行（`lt 4 JP_COLON`）
- **.**: タップで`.`、長押しでレイヤー5（スクロール）への一時移行（`lt 5 DOT`）
- **/**: スラッシュ（`SLASH`）
- **変換**: タップで`INT_HENKAN`、長押しでレイヤー6への一時移行（`lt_to_layer_0 6 INT_HENKAN`）
- **Space**: タップで`SPACE`、長押しでレイヤー2（数字）への一時移行（`lt 2 SPACE`）
- **無変換**: タップで`INT_MUHENKAN`、長押しでレイヤー3（矢印）への一時移行（`lt_to_layer_0 3 INT_MUHENKAN`）
- **Enter**: タップで`ENTER`、長押しでレイヤー1（ファンクション）への一時移行（`lt 1 ENTER`）
- **半角/全角**: 日本語入力切替（`JP_HANZEN`）
- **特殊キー**:
  - `[SS]`: `LS(LG(S))` - Shift+Win+S（スクリーンショット）
  - `[-]`: `MINUS` - マイナス記号
  - `[:]`: `JP_PLUS` - プラス記号（日本語キーボード対応）
  - `[;]`: `SEMICOLON` - セミコロン

#### レイヤー1: layer_1（記号・特殊文字）
記号や特殊文字の入力に使用します。

**詳細キー配置:**
```
行1: trans    &         *         (         )                              (         )         trans     trans     trans
行2: ~        $         %         ^         trans     trans   trans       {         }         ;         '         \
行3: `        !         @         #         trans     trans   trans       [         ]         :         "         |
行4: Ctrl+A/0 trans     trans     trans     trans     trans   trans       trans                                   trans
```

**キー詳細説明:**
- **行1**: アンパサンド（`AMPS`）、アスタリスク（`ASTERISK`）、左右の丸括弧（`LEFT_PARENTHESIS`、`RIGHT_PARENTHESIS`）
- **行2**: チルダ（`TILDE`）、ドル（`DLLR`）、パーセント（`PRCNT`）、ハット（`CARET`）、左右の波括弧（`LEFT_BRACE`、`RIGHT_BRACE`）、セミコロン（`SEMICOLON`）、シングルクォート（`SQT`）、バックスラッシュ（`NON_US_BACKSLASH`）
- **行3**: バッククォート（`GRAVE`）、エクスクラメーション（`EXCL`）、アットマーク（`AT`）、ハッシュ（`HASH`）、左右の角括弧（`LEFT_BRACKET`、`RIGHT_BRACKET`）、コロン（`COLON`）、ダブルクォート（`DOUBLE_QUOTES`）、パイプ（`PIPE`）
- **行4**: `lt 0 LC(A)` - タップでレイヤー0への移行、長押しでCtrl+A（全選択）

#### レイヤー2: layer_2（数字・ファンクションキー）
数字入力とファンクションキーの層です。

**詳細キー配置:**
```
行1: trans    F7        F8        F9        F10                            +         7         8         9         -
行2: trans    F4        F5        F6        F11       trans   trans       *         4         5         6         /
行3: ESC      F1        F2        F3        F12       F13     =           0         1         2         3         .
行4: Ctrl+A/0 trans     trans     trans     trans     trans   trans       trans                                   trans
```

**キー詳細説明:**
- **ファンクションキー**: F1〜F13まで配置
- **数字キー**: 0〜9をテンキー配列で配置
- **演算子**: `+`（プラス）、`-`（マイナス）、`*`（アスタリスク）、`/`（スラッシュ）、`=`（イコール）、`.`（ピリオド）
- **ESC**: エスケープキー（左下）

#### レイヤー3: layer_3（矢印・ナビゲーション）
カーソル移動とナビゲーション機能の層です。

**詳細キー配置:**
```
行1: BS       Ctrl+Shift+Tab    ↑         Ctrl+Tab         Del
行2: Home     ←                ↓         →                End       trans   trans
行3: Shift    Win+Shift+←      Shift+Tab Win+Shift+→      trans     trans   trans
行4: Ctrl+A/0 trans            trans     trans            trans     trans   trans
```

**キー詳細説明:**
- **矢印キー**: 上下左右の基本移動（`UP_ARROW`、`DOWN_ARROW`、`LEFT_ARROW`、`RIGHT_ARROW`）
- **ナビゲーション**: 
  - `Ctrl+Tab` - タブ切替
  - `Ctrl+Shift+Tab` - 逆タブ切替
  - `Home` - 行頭移動
  - `End` - 行末移動
  - `Shift+Tab` - 逆タブ
- **テキスト選択**:
  - `Win+Shift+←` - 単語単位で左選択（`LG(LS(LEFT_ARROW))`）
  - `Win+Shift+→` - 単語単位で右選択（`LG(LS(RIGHT_ARROW))`）
- **削除**: `BS`（バックスペース）、`Del`（デリート）

#### レイヤー4: layer_4（マウス機能）
マウス操作関連の機能層です。

**アクセス方法**:
- **自動**: トラックボール移動時に自動的にレイヤー4に切替（0.7秒後に自動復帰）
- **手動**: `L`キー長押しで一時移行

**詳細キー配置:**
```
行1: trans    trans     trans     trans     trans                          trans     trans     Ctrl+A    trans     スクロール/5
行2: trans    trans     trans     trans     trans     trans   trans       trans     左click   中click   右click   無変換で戻る
行3: trans    trans     trans     trans     trans     trans   Ctrl+Z      Ctrl+Shift+Z Ctrl+X  Ctrl+C    Ctrl+V    スクロール/5
行4: Ctrl+A/0 trans     trans     trans     trans     trans   trans       スクロール/5                               trans
```

**キー詳細説明:**
- **マウスクリック**:
  - 左クリック（`mkp MB1`）
  - 中クリック（`mkp MB3`）
  - 右クリック（`mkp MB2`）
- **編集操作**:
  - `Ctrl+A` - 全選択
  - `Ctrl+Z` - 元に戻す
  - `Ctrl+Shift+Z` - やり直し（`LC(LS(Z))`）
  - `Ctrl+X` - 切り取り
  - `Ctrl+C` - コピー
  - `Ctrl+V` - 貼り付け
- **レイヤー切替**:
  - `スクロール/5` - レイヤー5への一時移行（`mo 5`）
  - `無変換で戻る` - レイヤー0への移行+無変換キー（`lt_to_layer_0 0 INT_MUHENKAN`）

#### レイヤー5: layer_5（スクロール）
トラックボールスクロール機能用の層です。

**詳細キー配置:**
```
行1: trans    trans     trans     trans     trans                          SCRL_UP      SCRL_UP      SCRL_UP      SCRL_UP      SCRL_UP
行2: trans    trans     trans     trans     trans     trans   trans       SCRL_LEFT    PAGE_UP      ↑           PAGE_DOWN    SCRL_RIGHT
行3: trans    trans     trans     trans     trans     trans   trans       SCRL_LEFT    ←           ↓            →           SCRL_RIGHT
行4: Ctrl+A/0 trans     trans     trans     trans     trans   trans       SCRL_DOWN                                          SCRL_DOWN
```

**キー詳細説明:**
- **スクロール方向**:
  - 上スクロール（`msc SCRL_UP`）
  - 下スクロール（`msc SCRL_DOWN`）
  - 左スクロール（`msc SCRL_LEFT`）
  - 右スクロール（`msc SCRL_RIGHT`）
- **ページ移動**:
  - `PAGE_UP` - ページアップ
  - `PAGE_DOWN` - ページダウン
- **矢印キー**: 精密なカーソル移動用

#### レイヤー6: System/Bluetooth（システム・Bluetooth）
システム機能とBluetooth管理の層です。

**詳細キー配置:**
```
行1: trans    trans     trans     trans     trans                          BT1       BT2       BT3       BT4       BT5
行2: trans    trans     trans     trans     trans     trans   trans       trans     trans     trans     trans     trans
行3: trans    trans     trans     trans     trans     trans   bootloader  trans     trans     trans     trans     BT Clear
行4: Ctrl+A/0 trans     trans     trans     trans     trans   trans       trans                                   BT Clear All
```

**キー詳細説明:**
- **Bluetoothプロファイル**:
  - `BT1`〜`BT5` - デバイス1〜5の選択（`bt BT_SEL 0`〜`bt BT_SEL 4`）
- **Bluetooth管理**:
  - `BT Clear` - 選択中プロファイルのクリア（`bt BT_CLR`）
  - `BT Clear All` - 全プロファイルのクリア（`bt BT_CLR_ALL`）
- **システム**:
  - `bootloader` - ブートローダーモードへの移行

### 日本語キーボード設定

**完全対応**: OS設定を日本語キーボードのまま使用でき、すべての記号が正しく入力されます。

OS設定を日本語キーボードのまま使用するための変換定義が設定され、実際に適用されています：

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

| キー組み合わせ | キー位置 | 機能 | ZMKコード | 説明 |
|----------------|----------|------|-----------|------|
| W + E | 11 + 12 | Tab | `&kp TAB` | タブキー |
| E + R | 12 + 13 | Shift + Tab | `&kp LS(TAB)` | 逆タブ（シフトタブ） |
| S + W | 10 + 11 | 無変換 | `&to_layer_0 INT_MUHENKAN` | 無変換キー（レイヤー0に戻る+無変換） |
| S + D | 20 + 21 | " | `&kp JP_DQUOTE` | ダブルクォート（日本語キーボード対応） |
| M + , | 24 + 25 | = | `&kp JP_EQUAL` | イコール記号（日本語キーボード対応） |

**コンボキー詳細:**
- **タブ機能**: `W + E`で通常のタブ、`E + R`で逆方向タブ
- **日本語入力**: `S + W`で無変換キーを入力しつつレイヤー0に戻る
- **記号入力**: よく使用される記号をコンボで素早く入力

### エンコーダー・マウス機能

#### 左手側エンコーダー（ページ送り・タブ切替）
- **機能**: ページ送り・タブ切替
- **操作**: 
  - **デフォルトレイヤー**: 
    - 時計回り → Page Down（`PAGE_DOWN`）
    - 反時計回り → Page Up（`PG_UP`）
  - **レイヤー3（矢印・ナビゲーション）**:
    - 時計回り → Ctrl+Page Down（`LC(PAGE_DOWN)`）- 次のタブ
    - 反時計回り → Ctrl+Page Up（`LC(PAGE_UP)`）- 前のタブ
- **接続ピン**: 
  - A相: `xiao_d 5`
  - B相: `xiao_d 0`
- **ステップ数**: 24（1回転あたり）
- **センサーバインディング**: 
  - デフォルト: `sensor-bindings = <&inc_dec_kp PG_UP PAGE_DOWN>`
  - レイヤー3: `sensor-bindings = <&inc_dec_kp LC(PAGE_UP) LC(PAGE_DOWN)>`

#### 右手側トラックボール
- **センサー**: PixArt PMW3610
- **接続**: SPI通信（2MHz）
- **自動レイヤー切替**:
  - レイヤー4: マウスモード（トラックボール移動時、600ms後に自動復帰）
  - レイヤー5: スクロールモード（スクロールボタン押下時）
- **IRQピン**: `gpio0 2`（割り込み検知）
- **CSピン**: `gpio0 9`（SPI チップセレクト）
- **自動マウス機能**: PMW3610センサー内蔵機能（`automouse-layer = <4>`）で有効化
- **タイムアウト**: 700ms（`CONFIG_PMW3610_AUTOMOUSE_TIMEOUT_MS=700`）
- **ターゲットレイヤー**: レイヤー4（マウス機能）
- **移動検知閾値**: 0（`CONFIG_PMW3610_MOVEMENT_THRESHOLD=0`）

#### スクロール操作方法
1. **デフォルトレイヤーから**:
   - `.`キー長押し → トラックボール移動でスクロール
2. **マウスレイヤーから**:
   - スクロール切替ボタン押下 → トラックボール移動でスクロール
3. **スクロール方向**:
   - 上下移動: 縦スクロール
   - 左右移動: 横スクロール

#### スクロール設定
- **スクロール量**: 15（`ZMK_MOUSE_DEFAULT_SCRL_VAL`）
- **トリガー/回転**: 24（エンコーダーの物理ステップと同期）
- **最適化**: 一般的なマウスホイールと同様の感覚

### カスタムビヘイビア

#### `lt_to_layer_0`
- ホールド: 指定レイヤーへの一時移行
- タップ: レイヤー0への移行 + 指定キーの送信
- タッピング時間: 200ms

#### `to_layer_0` マクロ
- レイヤー0への移行とキー送信を組み合わせたマクロ
- 1パラメータのマクロ機能

#### `encoder_mouse_scroll`
- エンコーダー回転をマウススクロールに変換
- 時計回り: 上スクロール（`SCRL_UP`）
- 反時計回り: 下スクロール（`SCRL_DOWN`）
- 応答時間: 30ms

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
- `README.md`: プロジェクト概要とクイックスタート
- `docs/roBa-keyboard-settings.md`: 詳細設定ドキュメント

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

## Git/GitHub設定

### リポジトリ構成
- **Origin**: `https://fjdayo@github.com/fjdayo/zmk-config-roBa.git`
- **Upstream**: `https://github.com/kumamuk-git/zmk-config-roBa.git`

### 認証設定
- **認証方式**: Windows認証情報マネージャー（`wincred`）
- **Token**: Personal Access Token (PAT) 使用
- **自動保存**: 初回認証後、以降は自動で認証情報使用

### ビルド自動化
- GitHubへのプッシュで自動的にZMKファームウェアビルドが実行
- 生成されたファームウェアはGitHub Actionsからダウンロード可能

このドキュメントは設定の変更に伴って自動更新されます。

## 変更履歴

### 2024年12月 - ドキュメント詳細化
- **keymap-editor画面対応**: すべてのキー割り当てを詳細に記述
- **レイヤー別キー配置**: 各レイヤーの全キー位置と機能を明確化
- **コンボキー詳細**: キー組み合わせとZMKコードを明記
- **センサーバインディング**: エンコーダーの詳細な動作仕様を追加
- **キー機能説明**: タップ/長押し、Layer Tap機能の詳細を記載

### 最新の変更点

#### キーマップ変更
- **Qキー**: 長押し機能をESCに設定（`mt ESCAPE Q`）
- **Iキー**: 通常の`I`キーとして設定（レイヤー切替機能なし）
- **半角/全角切替**: 削除（日本語変換定義で対応）

#### エンコーダー機能追加
- **左手側エンコーダー**: マウススクロール機能を実装
- **スクロール感度**: 一般的なマウスレベルに調整
- **設定値**:
  - `triggers-per-rotation`: 24
  - `ZMK_MOUSE_DEFAULT_SCRL_VAL`: 15
  - `tap-ms`: 30

#### トラックボールスクロール機能追加
- **レイヤー5**: スクロール専用レイヤーとして機能実装
- **アクセス方法**: `.`キー長押し、マウスレイヤーのスクロール切替ボタン
- **スクロール方向**: 上下左右全方向対応
- **補助機能**: PageUp/PageDown、矢印キーによる精密制御

#### ハードウェア対応
- **右手側トラックボール**: PixArt PMW3610センサー搭載
- **自動レイヤー切替**: マウス操作時にレイヤー4、スクロール時にレイヤー5

#### ファイル構成
- **JSONファイル**: 左手側エンコーダーを有効化（`"enabled": true`）
- **DTSIファイル**: センサー配列を左手側エンコーダーのみに最適化
- **キーマップ**: エンコーダー用ビヘイビアとセンサーバインディング追加
- **READMEファイル**: プロジェクト概要と基本情報を追加

#### Git/GitHub統合
- **認証問題解決**: Windows認証情報マネージャーによる自動認証設定
- **プッシュテスト完了**: ユーザー選択ダイアログなしでスムーズなプッシュ実現
- **Personal Access Token**: GitHubアクセス用トークン設定完了
- **自動ビルド**: コミット・プッシュ時の自動ファームウェアビルド確認済み 