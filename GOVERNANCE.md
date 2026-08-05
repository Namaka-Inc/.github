# Global Linear and GitHub traceability contract

## Authority boundary

- Linear owns intent, project identity, priority, decisions, dependencies, and
  verified delivery status.
- GitHub owns implementation, review, commits, releases, and version history.
- Both systems must link to each other. Neither silently replaces the other.

## Before implementation

1. Search Linear for a project matching the exact repository, product, or
   runtime boundary.
2. Reuse the project when it exists.
3. When it does not exist, verify the unique project identity, source root,
   runtime, and owner before creating a project.
4. Assign the project to an existing initiative only when the authority domain
   is proven. Otherwise keep it explicitly unqualified with a Decision issue.
5. Create or reuse an executable Linear issue before planned work begins.

Do not create projects for features, releases, or temporary workflows. Use
issues and milestones.

## During implementation

Keep the Linear issue current with actual status, scope changes, blockers,
branch and pull request links, runtime geography, and current evidence level.
Failures and fallbacks must remain explicit and causal.

## Pull requests

Every planned implementation pull request must include:

- a Linear identifier in the form `SOD-123`;
- scope and negative scope;
- verification commands and observed results;
- risk and rollback information;
- a link back to the owning Linear issue.

The Linear issue must link to the pull request before the issue is marked Done.
Done requires the full verification contract, not merely merged code.

## Exceptions

Only active incident containment may begin without a pre-existing issue. The
exception must be documented in the pull request with:

- the immediate harm being contained;
- why prior registration was impossible;
- the retrospectively created Linear incident or issue;
- follow-up and rollback evidence.

No other silent exception or implicit fallback is permitted.

## Enforcement truth

Default files establish the policy but do not constitute a merge gate. Hard
enforcement exists only on repositories where the reusable validator (or a
documented stricter equivalent) is a required check on the protected default
branch. Never report global enforcement complete until every active repository
has been inventoried and tested through both a passing and failing pull request.

