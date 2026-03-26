---
name: pr-review
description: Use for final review of a diff, commit, branch, or uncommitted changes, focusing on concrete findings with severity, evidence, and missing tests. 最終レビューや自己レビューで、根拠つき指摘を整理したい時に使う。
---

# Purpose

レビューを「好み」ではなく「根拠のある指摘」に寄せる。

# When to use

- 実装後の自己レビュー
- PR 前の最終確認
- 特定 commit / diff / branch のレビュー
- 変更が広く、主要リスクを短時間で洗いたい

# Do not use

- 初期設計の壁打ち
- 実装方針が未確定の段階
- style-only feedback を大量に集めたい時

# Workflow

1. 何をレビュー対象にするか固定する
2. branch review なら明示的な range を決める
3. 必要なら `code_mapper` で前提を短く調査する
4. 高リスクな changed files から先に読む
5. `reviewer` で correctness / regression / security / tests を確認する
6. 指摘は重大度順に整理する
7. 指摘なしの場合も確認範囲と残る testing gap を明示する

# Output template

## Findings
- Severity:
- File:
- Evidence:
- Why it matters:
- Suggested fix:

## Missing tests
- ...

## Checked areas
- ...

# Quality bar

- 指摘は concrete findings を優先
- 再現条件、壊れるパス、具体ファイルを添える
- 根拠の薄い一般論は出さない
- diff snippet だけで断定せず、必要なら周辺コードまで読む
