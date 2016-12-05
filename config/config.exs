use Mix.Config

config :app,
  bot_name: "BGPHelperBot"

config :extwitter, :oauth, [
  consumer_key:        System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret:     System.get_env("TWITTER_CONSUMER_SECRET"),
  access_token:        System.get_env("TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
]

config :app, ecto_repos: [App.Repo]

config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("DATABASE_NAME"),
  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  hostname: System.get_env("DATABASE_HOSTNAME")

config :nadia,
  token: System.get_env("TELEGRAM_TOKEN")

import_config "#{Mix.env}.exs"
