defmodule CoolPlaces.Repo.Migrations.AlterDestinationAssetsRemoveDestinationId do
  use Ecto.Migration

  def up do
    drop_if_exists index(:destination_assets, [:destination_id],
                     name: :idx_destination_assets_destination_id
                   )

    alter table(:destination_assets) do
      remove_if_exists :destination_id, references(:destinations, on_delete: :delete_all)
    end
  end

  def down do
    alter table(:destination_assets) do
      add_if_not_exists :destination_id, references(:destinations, on_delete: :delete_all)
    end

    create_if_not_exists index(:destination_assets, [:destination_id],
                           name: :idx_destination_assets_destination_id
                         )
  end
end
