# Ghost Railway Template
# https://github.com/TryGhost/Ghost

FROM ghost:6-alpine AS base

EXPOSE 2368

ENV PORT=2368
ENV NODE_ENV=production

# Data is persisted via mounted volume at /var/lib/ghost/content on Railway
CMD ["npm", "start"]
