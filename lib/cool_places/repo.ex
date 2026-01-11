defmodule CoolPlaces.Repo do
  use Ecto.Repo,
    otp_app: :cool_places,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 20
end
