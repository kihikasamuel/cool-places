defmodule CoolPlaces.Repo.Migrations.CreateDestinations do
  use Ecto.Migration

  def up do
    create table(:destinations) do
      add :name, :string
      add :address, :map
      add :rating, :decimal
      add :status, :string
      add :country_id, references(:countries, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create_if_not_exists index(:destinations, [:country_id], name: :idx_destinations_country_id)
    create_if_not_exists index(:destinations, [:user_id], name: :idx_destinations_user_id)
  end

  def down do
    drop_if_exists index(:destinations, [:country_id], name: :idx_destinations_country_id)
    drop_if_exists index(:destinations, [:user_id], name: :idx_destinations_user_id)
    drop_if_exists table(:destinations)
  end
end
