ARG OS_IMAGE=node:16-alpine3.15

FROM ${OS_IMAGE} as deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk update && apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# used to host local development (see reference in docker-compose.yml)
FROM deps as dev
RUN apk update && apk add --no-cache bash
WORKDIR /app
CMD yarn install --frozen-lockfile && yarn dev

# used to host GitHub Actions CI/CD build execution
FROM deps as ci
WORKDIR /app
COPY . .

# build production assets and drop any dev dependencies afterwards
FROM ${OS_IMAGE} AS prod_build
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN yarn build

# production image, copy all the files and run the app
FROM ${OS_IMAGE} AS prod
WORKDIR /app

ENV NODE_ENV production

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

COPY --from=prod_build /app/next.config.js ./
COPY --from=prod_build /app/public ./public
COPY --from=prod_build --chown=nextjs:nodejs /app/.next ./.next
COPY --from=prod_build /app/node_modules ./node_modules
COPY --from=prod_build /app/package.json ./package.json

USER nextjs

EXPOSE 3000

# disable Next.js telemetry data collection.
# learn more here: https://nextjs.org/telemetry
ENV NEXT_TELEMETRY_DISABLED 1

CMD yarn start
