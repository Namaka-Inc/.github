#!/usr/bin/env bash
set -euo pipefail

title="${PR_TITLE:-}"
body="${PR_BODY:-}"
branch="${PR_BRANCH:-}"
combined="$title
$body
$branch"

failures=()

if ! grep -Eq '(^|[^A-Z0-9])SOD-[0-9]+([^0-9]|$)' <<<"$combined"; then
  failures+=("missing Linear identifier (expected SOD-123)")
fi

for heading in "## Summary" "## Scope" "## Verification" "## Risk and rollback"; do
  if ! grep -Fq "$heading" <<<"$body"; then
    failures+=("missing required section: $heading")
  fi
done

if ((${#failures[@]})); then
  printf 'Linear traceability validation failed:\n' >&2
  printf ' - %s\n' "${failures[@]}" >&2
  exit 1
fi

printf 'Linear traceability contract satisfied.\n'

