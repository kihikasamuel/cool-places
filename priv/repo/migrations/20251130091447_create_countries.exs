defmodule CoolPlaces.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION citext"

    create_if_not_exists table(:countries) do
      add :name, :citext
      add :code, :string
      add :emoji, :string
      add :dial_code, :string
      add :unicode_char, :string

      timestamps(type: :utc_datetime)
    end

    create_if_not_exists unique_index(:countries, [:code], name: :uidx_countries_code)
  end

  def down do
    drop_if_exists unique_index(:countries, [:code], name: :uidx_countries_code)
    drop_if_exists table(:countries)
    execute "DROP EXTENSION citext"
  end
end
