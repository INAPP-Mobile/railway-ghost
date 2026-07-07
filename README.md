# Deploy and Host

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/new/template/railway-ghost)

> **Canonical code:** `railway-ghost` — deploy URL: https://railway.com/new/template/railway-ghost

![OG Image](https://raw.githubusercontent.com/INAPP-Mobile/railway-ghost/main/og-image.svg)

Deploy a self-hosted Ghost CMS blog on Railway in one click. Ghost is a powerful, open-source publishing platform used by creators and startups worldwide.

## About Hosting

Ghost runs as a single container with a Railway-managed PostgreSQL database for content storage and a persistent volume at `/var/lib/ghost/content` for uploaded images, themes, and adapters. Railway provides the compute, TLS at the edge, and a public URL. The service restarts automatically on failures via Railway's built-in health check.

## Why Deploy

- **Professional blogging platform** — Ghost powers thousands of publications with a clean, fast editor and modern theme system.
- **Managed PostgreSQL** — Railway handles database provisioning, backups, and connection strings automatically.
- **Built-in membership & subscriptions** — Turn readers into paying members with native Stripe integration.
- **SEO optimized** — Clean URLs, automatic sitemaps, structured data, and fast page loads out of the box.
- **REST API** — Full content API for headless CMS use cases and custom frontends.
- **Zero-config deploy** — One click and Ghost is running with sensible production defaults.

## Common Use Cases

- **Personal blog** — Start writing immediately with the distraction-free editor.
- **Membership site** — Publish premium content behind a paywall with Stripe subscriptions.
- **Company blog** — Share product updates, changelogs, and engineering posts.
- **Newsletter** — Built-in email newsletter delivery to subscribers.
- **Headless CMS** — Use the Content API to power a custom frontend or mobile app.

## Dependencies for Ghost

### Deployment Dependencies

Ghost requires a PostgreSQL database and a persistent volume for uploaded content. Add a Railway PostgreSQL service to your project — the connection string is auto-injected via `DATABASE_URL`. A volume at `/var/lib/ghost/content` is auto-provisioned for image and theme persistence. For email delivery, configure SMTP via environment variables (Mailgun recommended).

---

## Features

- **Persistent volume** — Uploaded images and themes survive restarts via a volume at `/var/lib/ghost/content`
- **Managed PostgreSQL** — Railway provisions and manages your database
- **Single container** — Ghost 6 Alpine image, no sidecars needed
- **Health check endpoint** — `/ghost/api/admin/` monitored by Railway
- **Non-root user** — Runs as the `node` user inside the container
- **One-click deploy** — No local setup required

## Architecture

```
Railway Container
  ├── Ghost 6 (Alpine) → PORT, healthcheck
  ├── Volume: /var/lib/ghost/content → images, themes, adapters
  └── PostgreSQL (Railway-managed) → content, users, settings
```

1. Railway builds the Ghost image, attaches the volume, and provisions PostgreSQL
2. Environment variables (url, database config) are injected at runtime
3. Ghost connects to Postgres and serves on the Railway-assigned PORT
4. Uploaded images and themes persist in the attached volume
5. Health check monitors `/ghost/api/admin/`

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `url` | Yes | — | Public URL of your Ghost instance |
| `DATABASE_URL` | Yes | Auto | PostgreSQL connection (Railway auto-injects) |
| `database__client` | No | `postgres` | Database client type |
| `mail__transport` | No | `direct` | Email transport: `smtp`, `direct`, `mailgun` |
| `MAIL_OPTIONS_HOST` | No | — | SMTP host (if `mail__transport=smtp`) |
| `MAIL_OPTIONS_PORT` | No | `587` | SMTP port |
| `MAIL_OPTIONS_AUTH_USER` | No | — | SMTP username |
| `MAIL_OPTIONS_AUTH_PASS` | No | — | SMTP password |

## Getting Started

1. Click **Deploy on Railway** above.
2. Add a **PostgreSQL** service from the Railway marketplace.
3. Set `url` to match your Railway domain (e.g., `https://your-app.up.railway.app`).
4. Deploy — Ghost starts in ~60s on first build.
5. Visit your URL at `/ghost` to create your admin account.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| App not starting | Verify `DATABASE_URL` is set and Postgres is running |
| Health check fails | First deploy may take 2–3 minutes; retry |
| White screen at `/ghost` | Verify `url` matches your full Railway domain |
| SMTP not sending | Switch `mail__transport` to `smtp` with proper credentials |

## License

MIT. Ghost upstream is [MIT-licensed](https://github.com/TryGhost/Ghost). Template by [INAPP-Mobile](https://github.com/INAPP-Mobile).
