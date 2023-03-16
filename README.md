# CurrencyReader

**TODO: Add description**

## Local development

Start application:

```
$ docker compose up
```

Open terminal:

```
$ docker compose run --rm app sh
```

Open iex console:

```
$ docker compose run --rm app iex -S mix
```

## Production deploy

Deploy the app to `Fly.io` using Docker and building the image locally before deploy:

```
$ fly deploy --local-only --no-cache
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `currency_reader` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:currency_reader, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/currency_reader>.

