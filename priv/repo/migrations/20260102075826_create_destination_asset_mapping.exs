defmodule CoolPlaces.Repo.Migrations.CreateDestinationAssetMapping do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:destination_asset_mapping) do
      add :destination_id, references(:destinations, on_delete: :delete_all), null: false

      add :destination_asset_id, references(:destination_assets, on_delete: :delete_all),
        null: false

      timestamps(type: :utc_datetime)
    end
  end

  def down do
    drop_if_exists table(:destination_asset_mapping)
  end
end
