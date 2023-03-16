import Config

# Put here all ENV vars that need to be available at runtime.
# Since our build and deployment pipeline requires that our app’s environment
# variables be present at runtime, rather than build time, we need our release
# to have runtime configuration. To enable runtime configuration for our release,
# we created this file, config/releases.exs.
config :currency_reader,
  currency_api_url: System.fetch_env!("CURRENCY_API_URL"),
  currency_api_key: System.fetch_env!("CURRENCY_API_KEY")

