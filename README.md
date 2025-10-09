# yumemi_codecheck

## version
Flutter: 3.35.5
Dart SDK version: 3.9.2

## CI（GitHub Actions）
`main` ブランチの品質を保つために、GitHub Actions で自動チェックを実行しています。
Pull Request の作成時と main へのマージ時に以下の処理が走ります：

- **コードフォーマット検証**（`dart format`）
- **静的解析（Linter）**（`flutter analyze`）
- **テスト実行**（`flutter test`）
- **Android Debug ビルド確認**（`flutter build apk --debug`）