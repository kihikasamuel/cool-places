defmodule CoolPlaces.Seeds.Countries do
  require Logger

  def run() do
    Logger.info("Seeding Countries...")
    time = DateTime.utc_now() |> DateTime.truncate(:second)
    fields = ~w(name emoji dial_code unicode_char)a

    "#{__DIR__}/countries.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.map(&Map.drop(&1, [:image]))
    |> Enum.map(fn country ->
      country
      |> Map.merge(%{
        inserted_at: time,
        updated_at: time
      })
    end)
    |> then(
      &CoolPlaces.Repo.insert_all(CoolPlaces.Countries.Country, &1,
        on_conflict: {:replace, fields},
        conflict_target: [:code]
      )
    )
  end
end

require Logger

CoolPlaces.Seeds.Countries.run()
|> then(fn {count, _} ->
  Logger.info("Seeded #{count} countries.")
end)
