# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :cool_places,
  ecto_repos: [CoolPlaces.Repo],
  generators: [timestamp_type: :utc_datetime]

config :cool_places, CoolPlaces.Repo,
  migration_primary_key: [type: :binary_id, autogenerate: true],
  migration_foreign_key: [type: :binary_id],
  migration_timestamps: [type: :utc_datetime]

# Configures the endpoint
config :cool_places, CoolPlacesWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: CoolPlacesWeb.ErrorHTML, json: CoolPlacesWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: CoolPlaces.PubSub,
  live_view: [signing_salt: "/H6j7vVq"],
  # force_ssl is a compile time config
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :cool_places, CoolPlaces.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  cool_places: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  cool_places: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Poison

# oauth configuration
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile openid"]},
    twitter: {Ueberauth.Strategy.Twitter, []}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
if File.exists?("#{__DIR__}/#{config_env()}.exs") do
  import_config "#{config_env()}.exs"
else
  require Logger
  Logger.warning("Didn't find '#{config_env()}.exs'")
end
