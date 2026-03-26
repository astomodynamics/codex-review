---
name: git-commit
description: Use for creating a commit from staged or unstaged changes, matching repository commit style and executing git commit safely. staged / unstaged diff を確認して、repo の流儀に合う commit を作る時に使う。
---

# Purpose

変更内容を見て、適切な staging と commit message を決め、安全に commit する。

# When to use

- 実装後に commit を作りたい
- commit message を差分ベースで決めたい
- staged / unstaged のどちらを commit すべきか整理したい

# Do not use

- `--amend` が必要なケース
- rebase / squash / history rewrite
- ユーザーがまだ commit 対象を決めていない大きな作業途中

# Workflow

1. まず staged changes を確認する
2. staged が空なら unstaged changes を確認する
3. unstaged changes がある場合は、stage all / stage specific files / stop for manual staging を明示的に決める
4. 実際の staged diff を読み、repo の commit style を確認する
5. 具体的な commit subject を作る
6. repo が Conventional Commit を使うなら `<type>(scope?): <summary>` を優先する
7. header は 72 文字未満を目安にし、必要な場合だけ短い body を付ける
8. `git commit` を実行し、結果を報告する

# Required checks

- `git diff --staged --stat`
- 必要なら `git diff --stat`
- `git diff --staged --name-only`
- 必要なら対象ファイルの staged diff
- `git log -5 --oneline`

# Staging decisions

- stage all: `git add -A`
- stage specific files: `git add <paths>`
- manual staging: commit を止めて、今の状態と必要な次操作を返す

# Output template

## Commit plan
- Staging mode:
- Message:
- Why:

## Result
- Commit:
- Files:
- Remaining status:

# Guardrails

- diff を読まずに message を作らない
- user 指示なしで `--amend` しない
- user 指示なしで co-author trailer を付けない
- 無関係ファイルを勝手に staging しない
- message は filenames ではなく diff 内容から作る
- override の `-m "<message>"` 指示がある場合はそれをそのまま使う
