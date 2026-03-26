# Review Checklist

## Correctness
- 実装は依頼の目的を満たしているか
- 既存仕様を壊していないか
- null / empty / error path の扱いは妥当か

## Regression Risk
- 入口から出口まで実行経路はつながるか
- 条件分岐 / feature flag / config 差分で壊れないか
- 既存 callers / consumers に影響しないか

## Security / Safety
- 入力検証不足はないか
- 認可 / 認証 / 秘密情報の扱いに問題はないか
- ログに漏れてはいけない情報が出ないか

## Tests
- 修正に対応する回帰テストがあるか
- テストは brittle すぎないか
- 観点抜けはないか

## Docs / Operability
- API / schema / env / config の変更を文書化したか
- migration / rollout / fallback が必要なら明記したか
