# mydoc signed share link plan

Status: drafted + partially implemented locally
Date: 2026-04-02

## Goal
Keep `https://mydoc.inping.com/` password-protected by default, while allowing deliberate internal sharing through signed temporary URLs that do **not** expose the site broadly.

## Access model
1. Default access to the site still requires password / normal auth.
2. A signed share URL may bypass auth **only** for a single file under `content/public/`.
3. Signed URLs must not work for:
   - `content/private/`
   - `content/memory/`
   - `content/workspace-root/`
   - directory listing / index pages
4. Signed URLs should expire automatically.

## Recommended URL shape

```text
https://mydoc.inping.com/content/public/docs/example.md?share=1&expires=1712030400&sig=... 
```

## Signature scheme
Use HMAC-SHA256 instead of raw md5.

Payload:

```text
{path}|{expires}|share=1
```

Signature:

```text
base64url(HMAC_SHA256(secret, payload))
```

## Why not raw md5
- easy to replay if leaked
- typically no expiration binding
- too easy to design unsafely around a static secret
- not a strong signed-URL pattern compared with HMAC

## Local generator added
A local script now exists:

```bash
./scripts/mydoc-share-link.sh content/public/docs/example.md --ttl 86400
```

Environment:

- `MYDOC_SHARE_SECRET` required
- optional `MYDOC_PUBLIC_BASE`
- optional `MYDOC_SHARE_TTL_SECONDS`

## Current state
- local signed-link generator: implemented
- homepage exposure reduction: implemented earlier
- remote auth-bypass validator in reverse proxy: not yet implemented / not yet verified in current turn

## Remote implementation options
### Option A: reverse proxy native validation
If Caddy or Nginx can validate HMAC + expiry directly or through a helper endpoint, keep the file server behind that check.

### Option B: lightweight verifier service
Put a tiny local verifier in front of static files:
- validates `share`, `expires`, `sig`
- allows only `content/public/*`
- rejects directories
- proxies valid requests to the file root
- otherwise falls back to normal auth

## Verification checklist
Before claiming live share-link success:
1. unsigned access to site root -> auth required
2. unsigned access to `/content/public/...` -> auth required
3. expired signed link -> rejected
4. tampered path/signature -> rejected
5. valid signed link for one public file -> 200
6. signed link aimed at private/memory/workspace-root -> rejected

## Guardrail
Do not present signed-link sharing as live until the remote validator path is deployed and tested with current evidence.
