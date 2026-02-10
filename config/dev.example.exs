import Config

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# waffle configuration for local file storage
config :waffle,
  storage: Waffle.Storage.Local,
  # or {:system, "ASSET_HOST"}
  asset_host: "http://static.example.com"

# ## Ueberauth configurations for [google, x]
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "",
  client_secret: ""

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: "",
  consumer_secret: ""

# configure http_client
config :cool_places, CoolPlaces.Utils.HTTPClient, http_client: CoolPlaces.Utils.HTTPClient.Finch

# configuration for google places search
config :cool_places, CoolPlaces.Wrappers.Google.PlacesSearch,
  base_url: "",
  api_key: "",
  # if using gemini
  model: ""
