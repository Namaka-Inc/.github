#!/usr/bin/env bash
set -euo pipefail

title="${PR_TITLE:-}"
body="${PR_BODY:-}"
branch="${PR_BRANCH:-}"
combined="$title
$body
$branch"

failures=()

issue_id="$(grep -Eo 'SOD-[0-9]+' <<<"$combined" | head -n 1 || true)"
if [[ -z "$issue_id" ]]; then
  failures+=("missing Linear identifier (expected SOD-123)")
fi

if [[ -n "$issue_id" ]] && ! grep -Fq "/issue/${issue_id}/" <<<"$body"; then
  failures+=("missing Linear issue URL matching $issue_id")
fi

for heading in "## Summary" "## Scope" "## Verification" "## Risk and rollback"; do
  if ! grep -Fq "$heading" <<<"$body"; then
    failures+=("missing required section: $heading")
  fi
done

if grep -Fq "Incident exception: yes" <<<"$body"; then
  for field in "Immediate harm:" "Why prior registration was impossible:" "Follow-up:"; do
    if ! grep -Eq "${field}[[:space:]]*[^[:space:]]" <<<"$body"; then
      failures+=("incomplete incident exception field: $field")
    fi
  done
fi

if ((${#failures[@]})); then
  printf 'Linear traceability validation failed:\n' >&2
  printf ' - %s\n' "${failures[@]}" >&2
  exit 1
fi

printf 'Linear traceability contract satisfied.\n'
