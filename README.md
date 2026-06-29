# Ghost on Railway

Deploy a self-hosted [Ghost](https://ghost.org) blog on [Railway](https://railway.app) with a single click.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/ghost)

## One-Line Description

One-click self-hosted Ghost CMS on Railway — fast, clean blogging made simple.

## Features

- **Single Container** — no external dependencies beyond Postgres (Railway-managed)
- **Pinned Base Image** — `ghost:6-alpine` for reproducible builds
- **Non-Root User** — running as the `ghost` user inside the container
- **Health Check Endpoint** — `/health` monitored by Railway
- **One-Click Deploy** — no local setup required

## Architecture

```
┌─────────────────────┐         ┌──────────────────┐
│   your browser       │────────▶│  GitHub (source)  │
└─────────────────────┘         └──────────────────┘
                                ┌──────────────────┐
│                            │   Railway           │
│                              Docker build       │
│                              + Ghost app layer   │
│                            └──────────────────┘
│                                   │
│                     ┌─────────────────────────┐
│                     │  PostgreSQL (Railway)    │
│                     │  (content & metadata)    │
│                     └─────────────────────────┘
└─────────────────────────────────────────────────────┘
```

1. Push to Railway → Dockerfile builds the Ghost image from `ghost:6-alpine`
2. Railway sets environment variables (`url`, database config, etc.)
3. App connects to your Postgres instance and starts serving at port 2368
4. Health check hits `/health` periodically

## Environment Variables

| Variable | Description | Default | Notes |
|----------|-------------|---------|-------|
| `url` | Public URL of your Ghost instance | `https://your-app.railway.app` | Set in Railway project settings |
| `DATABASE_URL` | PostgreSQL connection string | — | Add a Postgres service on Railway for auto-fill |
| `database__client` | Database client | `postgres` | Override only if needed |
| `database__connection__host` | DB host | `localhost` | Set automatically when using Railway Postgres |
| `database__connection__port` | DB port | `5432` | Set automatically when using Railway Postgres |
| `database__connection__user` | DB user | `postgres` | Set automatically when using Railway Postgres |
| `database__connection__password` | DB password | — | Set automatically when using Railway Postgres |
| `database__connection__database` | Database name | `ghost` | Set automatically when using Railway Postgres |
| `mail__transport` | Email transport method | `direct` | Options: `smtp`, `direct`, `mailgun`, `sendmail` |

## Getting Started

1. Click **Deploy on Railway** above (or [deploy manually](https://railway.app/new)).
2. Add a **PostgreSQL** service from the Railway templates marketplace.
3. Copy the Postgres connection URL into your Ghost project settings for `DATABASE_URL`.
4. Set your public `url` to match the Railway provisioned domain.
5. Click **Deploy** — Ghost will start with ~60s boot time (first build).
6. Visit your deployment URL at `/ghost` to create your admin account.

## Troubleshooting

- **App not starting**: Check that `DATABASE_URL` is set and Postgres service is running in your Railway project.
- **Health check fails**: First deploy may take 2–3 minutes while the container initializes. Retry after a few minutes.
- **White screen at `/ghost/admin`**: Verify `url` matches your full Railway domain (e.g. `https://your-app-1234.railway.app`).
- **SMTP not sending emails**: Switch `mail__transport` to `smtp` and add `MAIL_OPTIONS_HOST`, `MAIL_OPTIONS_PORT`, `MAIL_OPTIONS_USER`, `MAIL_OPTIONS_PASSWORD`. Consider using [Mailgun](https://www.mailgun.com/) or [SendGrid](https://sendgrid.com/).
- **Postgres upgrade issues**: Always backup before upgrading Ghost versions. See [Ghost docs](https://ghost.org/docs/install/#upgrading-manually).

## License

MIT — copy, modify, and deploy as you wish.

## Resources

- [Ghost Docs](https://ghost.org/docs/)
- [Railway Docs](https://docs.railway.app/)
- [Ghost on GitHub](https://github.com/TryGhost/Ghost)
