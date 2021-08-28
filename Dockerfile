FROM joakimk/rpi-erlang:20.2.2
MAINTAINER Joakim Kolsjo <joakim.kolsjo<at>gmail.com>

# This is the same as https://github.com/bitwalker/alpine-elixir except the base image.

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=2018-01-30 \
    ELIXIR_VERSION=v1.6.1

WORKDIR /tmp/elixir-build

RUN \
    apk --no-cache --update upgrade && \
    apk add --no-cache --update --virtual .elixir-build \
      make && \
    apk add --no-cache --update \
      git && \
    git clone https://github.com/elixir-lang/elixir --depth 1 --branch $ELIXIR_VERSION && \
    cd elixir && \
    make && make install && \
    mix local.hex --force && \
    mix local.rebar --force && \
    cd $HOME && \
    rm -rf /tmp/elixir-build && \
    apk del .elixir-build


# ===========
# Application
# ===========

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# compile and build release
COPY lib lib
RUN mix do compile, release

FROM scratch AS app

WORKDIR /app
COPY --from=build /app/_build/prod/rel/ ./

CMD ["/bin/bash"]
