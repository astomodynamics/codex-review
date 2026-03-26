# AGENTS.md

このファイルは、このリポジトリで Codex に期待する **標準作業モード** を定義します。  
曖昧なときは、速度より **正確さ / 最小差分 / 再現可能な検証** を優先してください。

## 1. 最優先の原則

1. まず理解してから変える  
   - 変更前に、対象ファイル・呼び出し経路・設定・テスト位置を確認する。
2. 小さく変える  
   - 無関係な整理、命名変更、大規模移動を混ぜない。
3. 先に計画、後で実装  
   - 複雑・曖昧・多段の作業は、必ず短い計画を作ってから進める。
4. 検証を省略しない  
   - 変更した層に最も近い検証から順に回す。
5. 根拠を残す  
   - 完了報告では、何を見て判断したかを簡潔に示す。

## 2. デフォルトの作業フロー

### A. 調査
- 依頼の目的、制約、完了条件を整理する。
- 影響範囲を把握する。
- 不明点が大きい場合は、まず `docs/execution-plan.md` の形式で計画を作る。
- 実装前に次を確認する:
  - どの入口から処理が始まるか
  - どのモジュール / クラス / 関数が関与するか
  - 既存テストはどこか
  - 変更の横波は何か

### B. 実装
- 最小の変更で目的を達成する。
- 既存のコードスタイル、命名、テストの書き方に合わせる。
- 仕様変更を伴う場合は、関連ドキュメント・コメント・型定義も更新する。
- 依頼されていない設計刷新はしない。

### C. 検証
- まず狭い検証を行う
- 次に必要な範囲だけ広げる
- 使えるなら、以下の順を優先する:
  1. format / lint
  2. typecheck / compile
  3. unit test
  4. integration test
  5. e2e / manual verification

### D. 報告
最終報告は次の順で簡潔にまとめる:
1. 何を変えたか
2. なぜその変更にしたか
3. 実行した検証
4. 残るリスク / 未確認事項

## 3. 複雑タスクでは plan-first

次に該当する場合は、編集前に計画を出す:
- 3ファイル以上を触る
- 複数レイヤーに跨る
- 根本原因が未特定
- 既存仕様が曖昧
- 破壊的変更の可能性がある

計画には最低限以下を含める:
- Goal
- Constraints
- Impacted areas
- Step-by-step plan
- Validation plan
- Risks / rollback note

詳細テンプレートは `docs/execution-plan.md` を参照。

## 4. subagents の使い分け

### `code_mapper`
使う場面:
- 実装前の読解
- 呼び出し経路の追跡
- 影響範囲の棚卸し
- 差分レビュー前の前提整理

期待する成果:
- 入口
- 関連シンボル
- 依存関係
- 触るべきファイル候補
- 触ってはいけない周辺

### `reviewer`
使う場面:
- 実装前のリスク洗い出し
- 実装後の自己レビュー
- PR / diff / uncommitted changes のレビュー

期待する成果:
- 正しさ
- 回帰
- セキュリティ
- 競合状態
- 不足テスト
- ドキュメント不足

### `test_designer`
使う場面:
- バグ修正時の回帰テスト設計
- 新機能の最小テストセット設計
- flaky test の観点整理

期待する成果:
- 正常系
- 異常系
- 境界値
- 回帰ケース
- 過剰に brittle なテストの回避

### `docs_researcher`
使う場面:
- README / ADR / comments / schema / API docs の確認
- 実装と文書の齟齬確認
- 変更に伴う doc 更新範囲の洗い出し

### `surgical_fixer`
使う場面:
- 原因が分かった後の狭い実装修正
- 最小差分のパッチ
- 既存構造を壊さない局所修正

## 5. skills の使い分け

### `$execution-plan`
- 多段実装
- 仕様がまだ粗い変更
- 横断的な改修
- migration / rollout / phased delivery

### `$root-cause-debugger`
- バグ調査
- flaky test
- 例外やログからの原因特定
- 再現条件が揺れる不具合

### `$safe-refactor`
- 挙動を変えずに構造を整理したい時
- 命名整理、関数分割、重複除去、責務分離
- 先に守るべき不変条件を明示したい時

### `$test-matrix`
- 追加すべきテスト観点を整理したい時
- テスト不足を埋めたい時
- 修正に対して最小十分なケースを決めたい時

### `$pr-review`
- 変更の最終確認
- 重大度つきで指摘を整理したい時
- concrete findings のみを出したい時

### `$git-commit`
- commit 前に staging と message を整理したい時
- diff ベースで commit message を作りたい時
- repo の commit style に合わせたい時

### `$git-pr`
- branch diff から PR を作りたい時
- reviewer 向け説明を構造化したい時
- `.pr_description.md` と `gh pr create` まで進めたい時

### `$git-issue`
- issue から着手計画を作りたい時
- issue の要件と完了条件を整理したい時
- 必要に応じて `code_mapper` と組み合わせて影響範囲を調べたい時

この pack に同種の古い personal skill がある場合は、原則として pack 側の skill 名を優先する。

## 6. コマンド一覧: 必ず実値に置き換える

未設定なら、Codex は推測せず repo 内の既存スクリプト / 設定を確認してから選ぶこと。

- Install: `<fill-me>`
- Dev server: `<fill-me>`
- Format: `<fill-me>`
- Lint: `<fill-me>`
- Typecheck / Build: `<fill-me>`
- Unit test: `<fill-me>`
- Integration test: `<fill-me>`
- E2E test: `<fill-me>`

## 7. プロジェクトマップ: 必ず実態に合わせる

- App / service entrypoints: `<fill-me>`
- Domain / business logic: `<fill-me>`
- Shared libraries: `<fill-me>`
- Config / infra: `<fill-me>`
- Tests: `<fill-me>`
- Docs / ADRs / schemas: `<fill-me>`

## 8. 変更時のガードレール

- 依頼されていない依存追加は避ける
- 依頼されていない CI / infra / deployment 変更は避ける
- 無関係ファイルの format-only 変更を混ぜない
- public API / schema / contract を変える時は、影響範囲と更新点を明示する
- migration が必要なら、実装と同時に手順も示す
- 秘密情報・認証情報・鍵を生成 / 埋め込みしない
- 壊れやすい snapshot や implementation-detail 依存のテストを増やしすぎない

## 9. バグ修正の標準

バグ修正では次を優先:
1. 再現条件の明確化
2. 根本原因の特定
3. 最小修正
4. 回帰テスト
5. 周辺への副作用確認

必要なら `docs/debug-playbook.md` を使う。

## 10. レビューの標準

レビューでは `docs/review-checklist.md` に沿って確認する。  
指摘は **具体的な根拠があるものだけ** を優先し、好みの話は後回し。

## 11. Definition of Done

完了と見なす条件:
- 依頼された目的が満たされる
- 関連する主要パスが壊れていない
- 適切な検証を実行済み、または実行できない理由が明記されている
- 仕様変更がある場合、必要な docs / comments / types / tests が更新されている
- 残課題がある場合、明示されている

## 12. 最終報告テンプレート

```text
Summary
- ...

Files changed
- ...

Validation
- ...

Risks / follow-ups
- ...
```
