# Chat Mirror Deployment

## Goal

Deploy `chat-mirror` behind a real domain without replacing or colliding with existing local services.

## Required Inputs

- target server SSH access
- `ops/deploy.env`
- real `UPSTREAM_API_KEY`
- real SMTP credentials or a mail webhook for asset export email delivery
- domain DNS pointing at the target server
- reverse proxy configuration

## Files

- `Dockerfile`
- `docker-compose.yml`
- `ops/deploy.env.example`
- `ops/Caddyfile.example`
- `ops/nginx.example.conf`
- `scripts/deploy.sh`
- `scripts/domain-check.sh`

## Recommended Posture

- bind app container to `127.0.0.1:8791`
- put Caddy or Nginx in front of it
- do not bind directly to `0.0.0.0` unless you intentionally want raw port exposure
- if you enable streaming chat, disable proxy buffering and raise proxy read/send timeouts on the reverse proxy

## Deploy

1. Fill `ops/deploy.env`
2. Copy it to `ops/deploy.env`
3. Run:
```bash
./scripts/deploy.sh
```
4. Install reverse proxy config from `ops/Caddyfile.example` or `ops/nginx.example.conf`
5. Run domain verification:
```bash
./scripts/domain-check.sh your.domain.example
```

## Asset Email Delivery

If you want `导出并发送` to work as a real mail feature, configure one of these:

1. SMTP, recommended
```env
SMTP_HOST=smtp.your-provider.example
SMTP_HOST_IP=
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=mailer@your-domain.example
SMTP_PASS=your-smtp-password
SMTP_FROM=AibrowserAtlas <mailer@your-domain.example>
SMTP_REPLY_TO=support@your-domain.example
```

2. Mail webhook fallback
```env
ASSET_EMAIL_WEBHOOK_URL=https://your-mail-gateway.example/send
ASSET_EMAIL_WEBHOOK_SECRET=your-shared-secret
```

Priority:
- if SMTP is configured, the app sends mail directly over SMTP
- otherwise it falls back to the webhook path
- if neither is configured, the UI still generates assets, but email sending will fail with a clear configuration error

Notes:
- if your SMTP hostname is behind Cloudflare or another HTTP proxy, do not use the proxied IP for SMTP
- either switch the mail DNS record to `DNS only`, or set `SMTP_HOST_IP` to the real mail origin IP while keeping `SMTP_HOST` as the certificate hostname

## Acceptance Reminder

Domain cutover is not complete until:
- the domain serves this new system
- automated acceptance still passes
- the old program remains healthy
- the human confirms acceptance
