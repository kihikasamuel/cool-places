# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CoolPlaces.Repo.insert!(%CoolPlaces.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule CoolPlaces.Seeds do
  require Logger

  Logger.configure(level: :info)

  if Application.compile_env(:cool_places, :env) not in [:test] do
    [
      "countries.exs"
    ]
    |> Enum.each(fn file ->
      Code.require_file("#{:code.priv_dir(:cool_places)}/repo/seeds/#{file}", __DIR__)
    end)
  else
    Logger.info("Skipping seeds for #{Application.compile_env(:cool_places, :env)}")
  end
end
