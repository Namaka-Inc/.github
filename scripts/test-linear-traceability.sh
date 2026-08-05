#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
validator="$root/scripts/validate-linear-traceability.sh"

valid_body=$'## Summary\n- Add policy\n\n## Scope\n- Included: policy\n- Not included: rollout\n\n## Verification\n- Observed test\n\n## Risk and rollback\n- Revert commit'

PR_TITLE='[SOD-559] Add traceability policy' \
PR_BODY="$valid_body" \
PR_BRANCH='codex/sod-559-linear-traceability' \
"$validator"

if PR_TITLE='Missing issue' PR_BODY='## Summary' PR_BRANCH='feature/no-ticket' "$validator" >/dev/null 2>&1; then
  echo 'Expected invalid fixture to fail.' >&2
  exit 1
fi

echo 'Traceability validator fixtures passed.'

