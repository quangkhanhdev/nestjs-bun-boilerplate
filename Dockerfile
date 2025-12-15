FROM oven/bun:alpine AS base
WORKDIR /usr/src/app

# ------------------------ STAGE 1 ----------------------------
FROM base AS dev-deps

COPY package.json bun.lock /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile

# ------------------------ STAGE 2 ----------------------------
FROM base AS builder

COPY --from=dev-deps /temp/dev/node_modules ./node_modules
COPY . .

RUN bun run build

# ------------------------ STAGE 3 ----------------------------
FROM base AS prod-deps

COPY package.json bun.lock /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

# ------------------------ STAGE 4 ----------------------------
FROM base AS release

COPY --from=prod-deps /temp/prod/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist

ENV NODE_ENV=production
EXPOSE 3000/tcp

CMD [ "bun", "dist/main.js" ]