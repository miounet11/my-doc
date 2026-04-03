# Chat Mirror Runbook

## Preflight

1. Use Node `22` LTS:
   - `./scripts/with-node-lts.sh node -v`
2. Run the project doctor:
   - `../../scripts/projectctl.sh doctor chat-mirror`
3. On macOS, confirm Xcode Command Line Tools are installed:
   - `xcode-select -p`
4. Keep local dev bound to loopback unless you intentionally need LAN access:
   - default `HOST=127.0.0.1`

## Install

Server:
```bash
cd server
../scripts/with-node-lts.sh npm install
```

Web:
```bash
cd web
../scripts/with-node-lts.sh npm install
```

## Deploy

- fill `ops/deploy.env` from `ops/deploy.env.example`
- run `./scripts/deploy.sh`
- verify domain with `./scripts/domain-check.sh your.domain.example`

## Start

Server:
```bash
cd server
../scripts/with-node-lts.sh npm run dev
```

Web:
```bash
cd web
../scripts/with-node-lts.sh npm run dev
```

## Smoke Check

When the server is running, verify:
```bash
curl -sS http://127.0.0.1:8787/health
```

For acceptance evidence, do not stop at health:
```bash
./scripts/acceptance.sh http://127.0.0.1:8791
```

## Common Failures

- `better-sqlite3` or `bcrypt` compile failure:
  - switch to Node `22` LTS
  - install macOS Command Line Tools with `xcode-select --install`
- `UPSTREAM_API_KEY missing`:
  - fill `.env` from `.env.example`
