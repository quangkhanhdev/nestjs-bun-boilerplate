FROM oven/bun:alpine AS base
WORKDIR /usr/src/app

# ------------------------ STAGE 1 ----------------------------
FROM base AS dev-deps

COPY package.json bun.lock /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile

# ------------------------ STAGE 2 ----------------------------
FROM base AS builder
ENV DATABASE_URL="postgresql://db_user:admin123@postgres_db:5432/nestjs_app?schema=test"

COPY --from=dev-deps /temp/dev/node_modules ./node_modules
COPY . .

RUN bun db:gen
RUN bun run build

# ------------------------ STAGE 3 ----------------------------
FROM base AS prod-deps

COPY package.json bun.lock /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

# ------------------------ STAGE 4 ----------------------------
FROM base AS release

COPY --from=prod-deps /temp/prod/node_modules ./node_modules
COPY --from=builder /usr/src/app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /usr/src/app/dist ./dist
# require prisma schema and prisma config file for migrate deploy
COPY --from=builder /usr/src/app/prisma ./prisma
COPY --from=builder /usr/src/app/prisma.config.ts ./

ENV NODE_ENV=production

CMD ["sh", "-c", "bunx prisma migrate deploy && bun dist/main.js"]
