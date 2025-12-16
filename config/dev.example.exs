import Config

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# waffle configuration for local file storage
config :waffle,
  storage: Waffle.Storage.Local,
  asset_host: "http://static.example.com" # or {:system, "ASSET_HOST"}
