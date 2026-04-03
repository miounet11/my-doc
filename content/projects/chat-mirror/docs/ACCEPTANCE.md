# Chat Mirror Acceptance

Do not claim this project is complete unless all required checks are backed by fresh evidence.

## Required Before Saying "Done"

- Domain opens the new system, not the old API
- Registration succeeds
- Invite code `2026` is enforced and accepted correctly
- Login succeeds
- Chat succeeds
- Document generation succeeds
- Website package generation succeeds
- Memory write succeeds
- Upload succeeds
- Release metadata matches the intended public version
- Public downloads catalog exposes the current package matrix
- Public homepage download center renders exact package URLs
- Key package URLs return live downloadable artifacts
- Owner-approved direct cutover policy is in effect

## Current Rule

- Local install success is not completion
- Local build success is not completion
- Health endpoint success is not completion
- Public scripted acceptance is the release gate for productized launch
- Separate manual sign-off is no longer required for this project after the owner's 2026-03-13 release approval

## Evidence

Automatable local API checks:
```bash
./scripts/acceptance.sh http://127.0.0.1:8791
```

Automatable public release checks:
```bash
./scripts/acceptance.sh https://chat.aibrowseratlas.com https://www.aibrowseratlas.com
```

The public acceptance script now verifies:
- capability exposure for live creation modes and asset kinds
- real `DOCX` generation plus authenticated artifact download
- real website `ZIP` generation plus authenticated artifact download

Supportive isolation evidence:
```bash
./scripts/isolation-check.sh 8791
```

This is supportive only. It is no longer a blocking release gate after the owner-approved direct cutover decision.
