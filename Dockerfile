FROM elixir:1.14-alpine

RUN mkdir /app
WORKDIR /app
COPY . .

RUN apk update 

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

RUN mix compile

RUN mix release

EXPOSE 4000

CMD [ "mix", "ecto.reset" ]