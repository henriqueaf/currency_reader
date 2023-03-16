## Base stage ##
FROM elixir:1.14.3-alpine AS base

ARG ARG_APP_NAME=currency_reader

# ENV are available during image
# build and when the container is running.
ENV APP_HOME=/$ARG_APP_NAME

WORKDIR $APP_HOME

# Install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

## Development stage ##
FROM base AS dev
LABEL stage=development

COPY config/ $APP_HOME/config/
COPY mix.exs $APP_HOME/
COPY mix.* $APP_HOME/

RUN mix do deps.get

COPY . $APP_HOME/

CMD ["mix", "run", "--no-halt"]

## Pre-Production stage ##
FROM dev AS pre_prod

# ARG ARG_CURRENCY_API_URL
# ARG ARG_CURRENCY_API_KEY

# Put every ENV var required for build project here
RUN MIX_ENV=prod mix release --path /prod_build

# RUN --mount=type=secret,id=CURRENCY_API_URL \
#     --mount=type=secret,id=CURRENCY_API_KEY \
#     CURRENCY_API_URL="$(cat /run/secrets/CURRENCY_API_URL)" \
#     CURRENCY_API_KEY="$(cat /run/secrets/CURRENCY_API_KEY)" \
#     MIX_ENV=prod mix release --path /prod_build

## Production stage ##
FROM alpine AS prod

ARG ARG_APP_NAME=currency_reader

ENV APP_NAME=/$ARG_APP_NAME

RUN apk add ncurses-libs libstdc++

COPY --from=pre_prod /prod_build/ /elixir_prod_build

ENTRYPOINT /elixir_prod_build/bin/$APP_NAME start
