---
name: execution-plan
description: Use for multi-step features, migrations, cross-cutting refactors, or ambiguous tasks that benefit from planning before editing. 複雑な変更や曖昧なタスクで、編集前に計画が必要なときに使う。
---

# Purpose

複雑な変更で、いきなり編集に入らず **調査 → 計画 → 実装 → 検証** の順を守るための skill。

# When to use

- 3ファイル以上を触る見込みがある
- 複数レイヤーに跨る
- 仕様が曖昧
- migration / rollout / phased delivery が必要
- 不具合原因がまだ固まっていない

# Do not use

- 単純な typo 修正
- 明らかな 1 ファイル修正
- 既に実装計画が十分具体化されている小変更

# Workflow

1. Goal / constraints / done-when を再記述する
2. 必要なら `code_mapper` を使い、影響範囲と関連ファイルを調査する
3. thin vertical slice を先に置けるか検討する
4. 変更をフェーズに分ける
5. 各フェーズに検証方法を割り当てる
6. 依存関係、並列化できる作業、 migration / rollout / rollback 観点を明示する
7. 実装後に `reviewer` を使うべきタイミングがあれば含める

# Output template

## Goal
- ...

## Constraints
- ...

## Impacted areas
- ...

## Plan
1. ...
2. ...
3. ...

## Validation
- ...

## Risks
- ...

## Done when
- ...

# Quality bar

- 計画は実行可能であること
- 抽象論ではなく、ファイル / モジュール / 契約の粒度まで落とすこと
- 手順が多すぎる場合は、最小到達点 (thin vertical slice) を先に示すこと
- 可能なら各タスクを atomic and committable に分けること
