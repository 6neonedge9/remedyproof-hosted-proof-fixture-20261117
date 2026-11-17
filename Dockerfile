FROM node:22-bookworm-slim@sha256:5ec23b7c622b00547753bc6ffd78085dd868a68aeb41c8e0a1418f033e13d96d AS build
WORKDIR /site
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY next.config.mjs ./
COPY app ./app
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

FROM node:22-bookworm-slim@sha256:5ec23b7c622b00547753bc6ffd78085dd868a68aeb41c8e0a1418f033e13d96d
WORKDIR /site
COPY --from=build /site/.next/standalone ./
COPY --from=build /site/.next/static ./.next/static
ARG FIXTURE
ENV NODE_ENV=production HOSTNAME=0.0.0.0 PORT=8080 BUILD_LABEL=$FIXTURE
USER node
EXPOSE 8080
ENTRYPOINT ["node", "/site/server.js"]
