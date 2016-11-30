FROM elixir:1.3.4
MAINTAINER Raphael Tan <raphaeltanyw@gmail.com>

WORKDIR /usr/app

COPY . /usr/app

RUN mix local.hex --force
RUN mix deps.get

ENTRYPOINT ["mix", "server"]
