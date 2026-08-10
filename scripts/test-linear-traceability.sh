#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
validator="$root/scripts/validate-linear-traceability.sh"

valid_body=$'## Linear\nhttps://linear.app/sodersten-space/issue/SOD-559/enforce-global-github-to-linear-traceability-contract\n\n## Summary\n- Add policy\n\n## Scope\n- Included: policy\n- Not included: rollout\n\n## Verification\n- Observed test\n\n## Risk and rollback\n- Revert commit'

PR_TITLE='[SOD-559] Add traceability policy' \
PR_BODY="$valid_body" \
PR_BRANCH='codex/sod-559-linear-traceability' \
"$validator"

if PR_TITLE='Missing issue' PR_BODY='## Summary' PR_BRANCH='feature/no-ticket' "$validator" >/dev/null 2>&1; then
  echo 'Expected invalid fixture to fail.' >&2
  exit 1
fi

wrong_link_body="${valid_body/SOD-559/SOD-560}"
if PR_TITLE='[SOD-559] Wrong link' PR_BODY="$wrong_link_body" PR_BRANCH='codex/sod-559-wrong-link' "$validator" >/dev/null 2>&1; then
  echo 'Expected mismatched Linear link fixture to fail.' >&2
  exit 1
fi

incident_body="$valid_body"$'\n\nIncident exception: yes\nImmediate harm:\nWhy prior registration was impossible: outage\nFollow-up: SOD-559'
if PR_TITLE='[SOD-559] Incident' PR_BODY="$incident_body" PR_BRANCH='incident/sod-559' "$validator" >/dev/null 2>&1; then
  echo 'Expected incomplete incident exception fixture to fail.' >&2
  exit 1
fi

echo 'Traceability validator fixtures passed.'
