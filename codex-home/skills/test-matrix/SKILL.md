---
name: test-matrix
description: Use for deciding the minimal sufficient test set for a change, including happy path, edge cases, regressions, contracts, and anti-flake measures. 変更に対する最小十分なテストセットを決める時に使う。
---

# Purpose

「何をどこまでテストすれば十分か」を明確にする。

# When to use

- 新機能のテスト設計
- バグ修正後の回帰テスト設計
- 既存テストの抜け漏れ確認
- flaky test を安定化したい

# Do not use

- テスト実装より前の仕様未整理状態
- カバレッジ数字だけを追うタスク
- 実行コストが極端に高い網羅を作る場面

# Workflow

1. 変更の責務を 1 文でまとめる
2. テスト対象を層ごとに分解する
3. 正常系 / 異常系 / 境界値 / 契約 / 回帰 の観点を並べる
4. 最小十分セットと追加候補を分ける
5. brittle になりやすいケースを除外する
6. 既存テストスタイルに合わせる

# Output template

## Minimal set
- ...

## Edge cases
- ...

## Regression cases
- ...

## Cases to avoid
- ...

# Quality bar

- テスト目的が一目で分かること
- 変更内容に対して十分だが、過剰ではないこと
- 実装詳細に依存しすぎないこと
