# Ghost Railway Template
# https://github.com/TryGhost/Ghost

FROM ghost:6.51.0-alpine

# Railway injects PORT at runtime for health checks and routing.
# Ghost respects the PORT env var automatically.
ENV NODE_ENV=production

HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=5 \
  CMD curl -fsS "http://127.0.0.1:${PORT:-2368}/ghost/api/admin/" >/dev/null 2>&1 || exit 1

CMD ["npm", "start"]
