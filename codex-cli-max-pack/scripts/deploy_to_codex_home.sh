#!/usr/bin/env bash
set -euo pipefail

PACK_ROOT="/home/astomodynamics/github/codex-review/codex-cli-max-pack"
CODEX_HOME="$HOME/.codex"
BACKUP_ROOT="$CODEX_HOME/tmp/codex-cli-max-pack-backup-$(date +%Y%m%d-%H%M%S)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/codex-cli-max-pack.XXXXXX")"

cleanup() {
  rm -rf "$TMP_ROOT"
}
trap cleanup EXIT

echo "[deploy] backup -> $BACKUP_ROOT"
mkdir -p "$BACKUP_ROOT"
mkdir -p "$CODEX_HOME/agents" "$CODEX_HOME/skills" "$CODEX_HOME/tmp"

cp -a "$CODEX_HOME/config.toml" "$BACKUP_ROOT/config.toml"
if [[ -f "$CODEX_HOME/AGENTS.md" ]]; then
  cp -a "$CODEX_HOME/AGENTS.md" "$BACKUP_ROOT/AGENTS.md"
fi
if [[ -d "$CODEX_HOME/agents" ]]; then
  cp -a "$CODEX_HOME/agents" "$BACKUP_ROOT/agents"
fi
if [[ -d "$CODEX_HOME/skills/codex-delegation" ]]; then
  cp -a "$CODEX_HOME/skills/codex-delegation" "$BACKUP_ROOT/codex-delegation"
fi
if [[ -d "$CODEX_HOME/skills/codex-plan-mode" ]]; then
  cp -a "$CODEX_HOME/skills/codex-plan-mode" "$BACKUP_ROOT/codex-plan-mode"
fi

echo "[deploy] prepare generated home-layer files"
cp -a "$CODEX_HOME/config.toml" "$TMP_ROOT/config.toml"
python3 - <<'PY' "$TMP_ROOT/config.toml"
from pathlib import Path
import sys

path = Path(sys.argv[1])
text = path.read_text()
lines = [line for line in text.splitlines() if not line.startswith("max_threads = 24")]
text = "\n".join(lines).rstrip() + "\n"

agents_block = """
[agents]
max_threads = 6
max_depth = 1
job_max_runtime_seconds = 1800
"""

if "[agents]" in text:
    import re
    text = re.sub(
        r"\[agents\]\n(?:[^\[]*\n)*?",
        agents_block.lstrip("\n") + "\n",
        text,
        count=1,
        flags=re.MULTILINE,
    )
else:
    marker = "\n\n[tui]\n"
    if marker in text:
        text = text.replace(marker, "\n\n" + agents_block.strip() + "\n\n[tui]\n", 1)
    else:
        text = text.rstrip() + "\n\n" + agents_block.strip() + "\n"

path.write_text(text)
PY

cat > "$TMP_ROOT/AGENTS.md" <<'EOF'
# ~/.codex/AGENTS.md template

このファイルは **どの repo でも共通で守らせたい個人ルール** を置くテンプレートです。  
repo 固有ルールは各リポジトリの `AGENTS.md` に置き、このファイルは薄く保ってください。

## Personal working agreements

- 複雑タスクでは、実装前に短い計画を作る
- 変更理由と検証結果を最後に必ず要約する
- まず狭い検証から回し、必要な範囲だけ広げる
- 依存追加・CI変更・破壊的操作は、必要性を明示してから行う
- 不明点がある時は、既存コード・設定・テストを先に確認する
- 無関係な cleanup を混ぜない
- レビュー時は concrete findings を優先する
- バグ修正では回帰テスト候補を必ず考える

## Optional preferences

- 好みの package manager: `<fill-me>`
- よく使う lint command: `<fill-me>`
- よく使う test command: `<fill-me>`
- 先に見てほしい docs / notes: `<fill-me>`
EOF

echo "[deploy] install global AGENTS and config"
cp "$TMP_ROOT/AGENTS.md" "$CODEX_HOME/AGENTS.md"
cp "$TMP_ROOT/config.toml" "$CODEX_HOME/config.toml"

echo "[deploy] replace legacy agents with max-pack agents"
rm -f "$CODEX_HOME/agents/bug-analyzer.md" "$CODEX_HOME/agents/plan-reviewer.md"
cp "$PACK_ROOT/.codex/agents/"*.toml "$CODEX_HOME/agents/"

echo "[deploy] install max-pack skills"
for skill_dir in "$PACK_ROOT"/.agents/skills/*; do
  skill_name="$(basename "$skill_dir")"
  mkdir -p "$CODEX_HOME/skills/$skill_name"
  cp "$skill_dir/SKILL.md" "$CODEX_HOME/skills/$skill_name/SKILL.md"
done

echo "[deploy] patch compatibility skills"
if [[ -f "$CODEX_HOME/skills/codex-delegation/SKILL.md" ]]; then
  python3 - <<'PY' "$CODEX_HOME/skills/codex-delegation/SKILL.md"
from pathlib import Path
import sys

path = Path(sys.argv[1])
text = path.read_text()
text = text.replace(
    "1. **Identify the expert type**: bug-analyzer, code-reviewer, or plan-reviewer",
    "1. **Identify the expert prompt type**: bug-analysis, code-review, or plan-review",
)
path.write_text(text)
PY
fi

echo "[deploy] remove redundant legacy skills"
rm -rf \
  "$CODEX_HOME/skills/create-commit" \
  "$CODEX_HOME/skills/create-pr" \
  "$CODEX_HOME/skills/codex-debugger" \
  "$CODEX_HOME/skills/planner" \
  "$CODEX_HOME/skills/codex-plan-mode" \
  "$CODEX_HOME/skills/pr-review-toolkit"

echo "[deploy] done"
echo "backup=$BACKUP_ROOT"
