import Config

# You can set the ENV vars inside the file .env.container
# on repository root folder.
config :currency_reader,
  currency_api_url: System.get_env("CURRENCY_API_URL"),
  currency_api_key: System.get_env("CURRENCY_API_KEY")
