# Deployment

## Local
- `make dev`
- `make smoke`
- `make audit`
- `make serve`

## Docker
- `docker compose build`
- `docker compose up --build`
- `curl http://127.0.0.1:3000/health`

## Server
1. Create `ops/deploy.env` from `ops/deploy.env.example`
2. Fill `DEPLOY_HOST`, `DEPLOY_USER`, `DEPLOY_PATH`, `DEPLOY_PORT`
3. Run `./scripts/deploy.sh`
4. Verify:
   - `curl http://SERVER:3000/health`
   - `docker compose ps`
   - `./scripts/smoke.sh`

## Notes
- Service entrypoint is `./scripts/serve.sh`
- Main audit report is `data/retrospectives/final-review.md`
- If you want a reverse proxy later, keep app on `APP_PORT=3000`; local default host is `127.0.0.1`, container/server host should be `0.0.0.0`
