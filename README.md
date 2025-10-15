# Yumemi Codecheck
株式会社ゆめみ様Flutter エンジニアコードチェック課題

## 開発環境
- Flutter: 3.35.5
- Dart SDK version: 3.9.2

## 伝達事項
- このプロジェクトでは、GitHub OAuth 認証に必要なクライアント情報などを.env ファイルで管理しています。お手数ですが、.env.exampleを参考にルートディレクトリ直下に .envファイルを作成し、必要な値の設定をお願いします。
- 実装前の設計やタスクの分割にはfigmaを使用しました。
- .env, figmaのURLをメールにて送信いたしましたので,ご確認いただけますと幸いです。

## 設計
- このアプリは MVVMアーキテクチャを参考に以下のパイプラインに沿って構築しています。

```mermaid パイプライン

flowchart LR

API[API]

Entity[Entity（APIModel）]

Repo[Repository]

Provider[RepositoryProvider]

VM[ViewModel]

State[State（UIModel）]

View[View]

API -->|JSON| Entity

Entity --> Repo

Repo --> Provider

Provider --> VM

VM --> State

State --> View

```
設計の詳細は[ARCHITECTURE.md](https://github.com/kota78/yumemi-codecheck/blob/feature/comment/ARCHITECTURE.md)に記載しています。

## 実装した機能
### リポジトリ検索
- 検索ボックスに文字を入力し確定すると、リポジトリ名の一覧が表示される
- riverpod_paging_utilsを使用
	- リクエストエラー時、標準のviewでは多言語対応が難しかったため、CustomErrorView作成し使用
### リポジトリ情報の詳細表示
- リポジトリ名をタップすると，詳細ページに遷移
	- リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数を表示
- 戻るボタンを押下すると戻る
### OAuth認証によるログイン機能
- 検索ページ右上のユーザーアイコンを押すことでログインができる
	- ログイン時はログインユーザーの画像に切り替わる
- アクセストークンをヘッダに添付する
	- リクエスト制限が緩和
- アクセストークンは端末に保存し，再起動時に有効なトークンがあればログイン状態を保持
	- flutter_secure_storageを使用
- 環境変数の読み込み
	- flutter_dotenvを使用
	- CI上ではGitHub上でSecretsを定義し.envファイルを作成
### ダークモードへの対応
- 基本は既存のThemeを切り替えることで対応
- 検索ボックス等一部は個別対応
### 多言語対応
- flutter_localizationsを使用
- 英語，日本語に対応

## CI（GitHub Actions）
- `main` ブランチの品質を保つために、GitHub Actions で自動チェックを実行しています。
- Pull Request の作成時と main へのマージ時に以下の処理が走ります：
	- **静的解析（Linter）**（`flutter analyze`）
		- リントルールにはyumemi_lintsを採用
	- **テスト実行**（`flutter test`）
	- **Android Debug ビルド確認**（`flutter build apk --debug`）

## スクリーンショット
### 検索ページ（未入力時）　日本語/英語 通常モード/ダークモード
<img width="240" alt="simulator_screenshot_B0EFD005-BF25-400C-8609-A0E8E284DEE3" src="https://github.com/user-attachments/assets/b6d1f69a-e05b-40d9-a272-9894988768de" />
<img width="240" alt="simulator_screenshot_839BD0CE-ECB7-4FDE-BB6B-6208D1ADC331" src="https://github.com/user-attachments/assets/81deddf3-120e-4b77-b172-f570b3902879" />
<img width="240" alt="simulator_screenshot_7530A2A3-37FA-4593-9225-A32EA0BC838F" src="https://github.com/user-attachments/assets/f88b4bcb-5666-4ee3-946e-42d5346f47cc" />
<img width="240" alt="simulator_screenshot_46073DFE-F52A-4DD9-9AC9-4502A6A7DF78" src="https://github.com/user-attachments/assets/7fa57598-29cf-43eb-b0d0-e94f1717fc28" />

### 検索ページ（検索ワード入力時）
<img width="240" alt="simulator_screenshot_6D9F1A16-7AF8-46E9-9A54-6029C8737B35" src="https://github.com/user-attachments/assets/8ebf38d2-d166-441e-8477-be6edaee4a8a" />

### 詳細ページ
<img width="240" alt="simulator_screenshot_A1432260-A4F9-440C-AABB-7C01C6E75314" src="https://github.com/user-attachments/assets/cf99ed26-73fa-4c79-bbb5-208cea7f2636" />

### ログインボタン押下時
<img width="240" alt="simulator_screenshot_7A928C2D-57E7-4935-A2AD-033C4AC9C9BE" src="https://github.com/user-attachments/assets/60bf1f38-bcce-41ee-bef3-52516037136e" />
<img width="240" alt="simulator_screenshot_6104DFB9-DE3D-49B9-8EC3-F6CBA36F00A1" src="https://github.com/user-attachments/assets/40611052-db97-4a87-bf52-d218eaac2224" />

### ログイン後
<img width="240" alt="simulator_screenshot_DBFF029D-C0B2-4CFD-A0C9-0443C43565A0" src="https://github.com/user-attachments/assets/d938dfeb-8f6b-4da3-b97d-db77a3f551ef" />
