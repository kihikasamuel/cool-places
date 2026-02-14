defmodule CoolPlaces.Repo.Migrations.CreateVisitors do
  use Ecto.Migration

  def up do
    create table(:visitors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :ip_address_hash, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :city, :citext
      add :region, :citext
      add :country, :citext
      add :country_code, :citext
      add :timezone, :citext
      add :user_agent, :citext
      add :visited_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:visitors, [:visited_at])
    create index(:visitors, [:country_code])
  end

  def down do
    drop_if_exists index(:visitors, [:visited_at])
    drop_if_exists index(:visitors, [:country_code])
    drop table(:visitors)
  end
end
