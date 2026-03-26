---
name: safe-refactor
description: Use when behavior should stay the same but structure should improve, such as extracting functions, reducing duplication, clarifying names, or separating responsibilities. 挙動維持のまま整理したい安全なリファクタに使う。
---

# Purpose

挙動を変えずに、読みやすさ・保守性・局所性を改善する。

# When to use

- 重複除去
- 関数分割
- 責務分離
- 名前の明確化
- 長すぎる条件分岐やメソッドの整理

# Do not use

- 仕様変更
- パフォーマンス改善を兼ねた大改造
- public API / schema / persistence contract を変える改修

# Workflow

1. 守るべき不変条件を列挙する
2. 既存テストや型でガードできる点を確認する
3. 変更を小刻みに分割する
4. 1 ステップごとに format / lint / test を回せる形にする
5. 必要なら `test_designer` で不足テストを補う
6. 最後に `reviewer` で回帰リスクを確認する

# Output template

## Invariants
- ...

## Refactor steps
1. ...
2. ...
3. ...

## Validation
- ...

## Behavior unchanged because
- ...

# Quality bar

- 機能追加を混ぜない
- diff を読みやすく保つ
- 元の責務境界を壊すなら、その理由を明示する
