defmodule CoolPlaces.Destinations.DestinationAssetMapping do
  use Ecto.Schema
  # import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "destination_asset_mapping" do
    belongs_to :destinations, CoolPlaces.Destinations.Destination, foreign_key: :destination_id

    belongs_to :destination_asset, CoolPlaces.Destinations.DestinationAsset,
      foreign_key: :destination_asset_id

    timestamps(type: :utc_datetime)
  end
end
