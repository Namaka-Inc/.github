# Namaka-Inc GitHub governance

This repository is the organization-wide source for default GitHub community
health files and the GitHub side of the Linear traceability contract.

## Mandatory contract

Planned implementation work requires:

1. an existing Linear project matching the repository, product, or runtime;
2. a Linear issue before execution starts;
3. the Linear identifier in the branch, commit, or pull request;
4. bidirectional links between Linear and GitHub;
5. documented verification and risk or rollback information before merge.

If no matching Linear project exists, qualify and create it according to the
[global policy](GOVERNANCE.md) before creating implementation issues. Features
and releases belong in issues and milestones, not new projects.

Emergency remediation may begin before registration only to stop active harm.
The incident and resulting work must be registered immediately after the system
is stable.

## Enforcement status

The policy and default templates are active organization defaults. The reusable
validator is available at:

```yaml
uses: Namaka-Inc/.github/.github/workflows/linear-traceability.yml@main
```

Templates communicate the contract but do not stop a merge. A repository is
hard-enforced only after the validator is installed and configured as a required
check on its protected default branch. Rollout is tracked in Linear issue
`SOD-559`.

The observed repository-by-repository rollout state is recorded in
[`repository-inventory.json`](repository-inventory.json). A blocked protection
API is reported as blocked, never as enforcement.
