defmodule CoolPlaces.Repo.Migrations.CreateDestinationAssets do
  use Ecto.Migration

  def up do
    create table(:destination_assets) do
      add :destination_id, references(:destinations, on_delete: :delete_all)
      add :is_destination_cover?, :boolean, default: false
      add :asset_type, :string
      add :asset_url, :string

      timestamps(type: :utc_datetime)
    end

    create_if_not_exists index(:destination_assets, [:destination_id], name: :idx_destination_assets_destination_id)
  end

  def down do
    drop_if_exists index(:destination_assets, [:destination_id], name: :idx_destination_assets_destination_id)
    drop_if_exists table(:destination_assets)
  end
end
