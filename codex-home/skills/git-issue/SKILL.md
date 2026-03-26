---
name: git-issue
description: Use for reading an issue, summarizing the problem, mapping likely impact, and producing an implementation or investigation plan. issue を読んで、論点整理・影響範囲・着手計画を作る時に使う。
---

# Purpose

Issue をそのまま実装に飛ばさず、まず「何が問題か」「どこに効くか」「どう着手するか」を整理する。

# When to use

- issue 番号や URL から着手計画を作りたい
- issue の要件や完了条件を整理したい
- issue の影響範囲が広そうで、先に調査が必要

# Do not use

- 既に原因と修正箇所が確定している単純修正
- issue 作成そのものが目的
- issue 内容が空で、追加情報もなく何も判断できないケース

# Workflow

1. issue source を確定する
2. 可能なら `gh issue view` などで本文・受け入れ条件・関連情報を取る
3. issue を Goal / constraints / done-when に要約する
4. 必要なら `code_mapper` で実装入口と影響範囲を調査する
5. 必要なら `docs_researcher` で契約・README・ADR との整合を確認する
6. 実装プランまたは調査プランを作る
7. 未知点、 blockers、最初の安全な着手面を示す

# Output template

## Issue summary
- Goal:
- Constraints:
- Done when:

## Likely impact
- Entry points:
- Relevant files / modules:
- Risks / unknowns:

## Suggested next steps
1. ...
2. ...
3. ...

## Validation outline
- ...

# Guardrails

- issue 本文がない場合は、与えられた情報以上を断定しない
- いきなり実装に進まず、まず着手可能な plan に落とす
- `gh` が使えない場合は、paste された issue 文面をソースにする
- issue triage が目的なので、勝手に issue を close / mutate しない
