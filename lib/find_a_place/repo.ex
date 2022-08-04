defmodule FindAPlace.Repo do
  use Ecto.Repo,
    otp_app: :find_a_place,
    adapter: Ecto.Adapters.Postgres
end
