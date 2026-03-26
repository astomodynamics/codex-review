# Codex CLI Max Pack

このパックは、Codex CLI を **AGENTS.md + Skills + subagents** で実戦投入しやすくするためのテンプレートです。

## 含まれるもの

- `AGENTS.md`
  - リポジトリ全体の作業規約
  - 計画、探索、実装、検証、報告の流れ
  - subagents / skills をいつ使うか
- `.codex/config.toml`
  - subagents の並列設定
- `.codex/agents/*.toml`
  - 専門エージェント定義
- `.agents/skills/*/SKILL.md`
  - 再利用できるワークフロー
  - planning / review / debug に加えて Git workflow も含められる
  - planning / review / debug に加えて Git workflow も含められる
- `docs/*.md`
  - 計画、レビュー、デバッグの補助テンプレート

## 導入

1. このディレクトリ配下のファイルを対象リポジトリへコピー
2. `AGENTS.md` の **コマンド欄** と **プロジェクト固有ルール** を埋める
3. 必要なら `~/.codex/AGENTS.md` に個人共通ルールを追加
4. 必要なら `~/.agents/skills` に個人用 skills を移設
5. Codex を repo root から起動

## まず埋める場所

- `AGENTS.md`
  - Install / Dev / Lint / Test / Build コマンド
  - 重要ディレクトリ
  - 禁止事項
  - Definition of Done
- `.codex/config.toml`
  - `max_threads`
  - `max_depth`
- `.codex/agents/*.toml`
  - 必要なら `sandbox_mode` や `nickname_candidates` を調整

## 使い方の例

### 1. 大きめの実装
```text
Use $execution-plan first.
そのうえで code_mapper で影響範囲を洗い出し、reviewer で主要リスクを並列確認しながら実装してください。
```

### 2. バグ調査
```text
Use $root-cause-debugger.
Spawn code_mapper to trace the execution path and test_designer to propose the smallest regression test.
```

### 3. リファクタ
```text
Use $safe-refactor.
挙動を変えずに整理したいです。必要なら reviewer で回帰リスクも見てください。
```

### 4. PR 前の自己レビュー
```text
Use $pr-review.
Spawn reviewer and summarize only concrete findings with severity, evidence, and suggested fixes.
```

### 5. コミット作成
```text
Use $git-commit.
変更内容を見て、repo の流儀に合う commit message を作って commit してください。
```

### 6. PR 作成
```text
Use $git-pr.
現在の branch diff から PR title / body を作って gh で PR を作成してください。
```

### 7. Issue から着手計画
```text
Use $git-issue.
Issue #123 を読んで、影響範囲と実装ステップを整理してください。必要なら code_mapper を使ってください。
```

### 5. コミット作成
```text
Use $git-commit.
変更内容を見て、repo の流儀に合う commit message を作って commit してください。
```

### 6. PR 作成
```text
Use $git-pr.
現在の branch diff から PR title / body を作って gh で PR を作成してください。
```

### 7. Issue から着手計画
```text
Use $git-issue.
Issue #123 を読んで、影響範囲と実装ステップを整理してください。必要なら code_mapper を使ってください。
```

## おすすめ運用

- repo 共通ルールは `AGENTS.md`
- 個人共通ルールは `~/.codex/AGENTS.md`
- チームで共有したい再利用ワークフローは `.agents/skills`
- 明確に役割分担したいものは `.codex/agents`
- 長文化しすぎる前に、詳細は `docs/*.md` に逃がして `AGENTS.md` は薄く保つ
- Git の操作系は agent より skill に寄せると、確認フローと実行条件をまとめやすい
- 役割が重なる古い個人 skill がある場合は、pack 側を優先し、重複 skill は段階的に整理する
- Git の操作系は agent より skill に寄せると、確認フローと実行条件をまとめやすい

## 補足

このパックは **汎用テンプレート** です。  
最終的な精度は、`AGENTS.md` にその repo の **実コマンド** と **本当に守るべき規約** を書くほど上がります。
