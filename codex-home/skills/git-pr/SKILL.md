---
name: git-pr
description: Use for drafting a pull request from the current branch diff, writing a PR body file, and creating the PR with GitHub CLI. branch diff から PR title / body を作り、gh で PR を作成する時に使う。
---

# Purpose

現在の branch diff を根拠に、再現可能な PR title / body を作って `gh pr create` まで進める。

# When to use

- 実装後に PR を作りたい
- branch diff から reviewer 向け説明を整理したい
- `.pr_description.md` を自動生成したい

# Do not use

- まだ diff が不安定で PR 範囲が固まっていない
- draft の文章だけ欲しくて、PR 作成はしないケース
- `gh` 未認証のまま実行を確定できないケース

# Workflow

1. branch / status / diff を確認する
2. 変更内容から concise で behavior-focused な PR title を作る
3. Summary, Changes, Test Plan, Related Issues, How to Test, Screenshots/Videos, Additional Notes を順番どおり埋める
4. placeholder を残さず、各 test claim を実コマンドまたは not run に対応づける
5. repo root に `.pr_description.md` を書く
6. `gh pr create --title ... --body-file .pr_description.md` を実行する
7. PR URL または失敗理由を返す

# Required checks

- `git rev-parse --abbrev-ref HEAD`
- `git status --short`
- `git diff --stat`
- 必要なら `git diff`

# Output template

## PR draft
- Title:
- Body file: `.pr_description.md`
- Main changes:

## Result
- Command:
- URL or error:

# Guardrails

- diff にない主張を書かない
- test claim は実際のコマンドか明確な未実行メモにする
- placeholder を残さない
- `gh` の auth 問題がある時は原因を明示する
- draft だけでなく、実行した `gh pr create` コマンドと結果を報告する
