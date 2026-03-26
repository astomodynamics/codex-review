---
name: root-cause-debugger
description: Use for bug hunts, flaky tests, regressions, runtime exceptions, or confusing behavior where the root cause is not yet known. 原因未特定の不具合調査や flaky test の切り分けに使う。
---

# Purpose

「症状」から「根本原因」まで最短距離で辿り、最小修正と回帰テストにつなげる。

# When to use

- エラーや例外は見えているが原因が不明
- flaky test や環境依存不具合を切り分けたい
- 直したつもりなのに再発する
- ログ、stack trace、diff のどこを見るべきか散っている

# Do not use

- 既に原因が確定している単純修正
- 仕様追加の相談
- 大規模リファクタ計画

# Workflow

1. 症状を 1 文で固定する
2. 再現条件を明確化する
3. 既存ログ / stack trace / recent diff / failing tests を集め、必要なら self-contained な log bundle を作る
4. relevant env / runtime / dependency 情報を、必要なときだけ一緒に固定する
5. 必要なら `code_mapper` で実行経路をトレースする
6. 仮説を 2〜3 個までに絞る
7. 一番安い確認から潰す
8. 根本原因を特定したら `surgical_fixer` で最小修正に渡す
9. `test_designer` を使って最小の回帰テストを決める

# Evidence bundle

可能なら以下を揃える:

- failing command / script
- expected vs actual behavior
- stderr / traceback / assertion
- relevant env vars
- `git status -sb` と recent diff
- failing test name または reproduction steps

# Output template

## Symptom
- ...

## Reproduction
- ...

## Evidence
- ...

## Hypotheses
1. ...
2. ...
3. ...

## Root cause
- ...

## Fix shape
- ...

## Regression test
- ...

# Quality bar

- 直接原因と根本原因を区別する
- 「たぶん」ではなく、証拠に基づく絞り込みを行う
- 修正案は最小であること
- 再現ログや evidence を残せるなら bundle path も返すこと
