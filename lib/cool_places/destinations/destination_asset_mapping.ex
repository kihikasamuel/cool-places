defmodule CoolPlaces.Destinations.DestinationAssetMapping do
  use Ecto.Schema
  # import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "destination_asset_mapping" do
    belongs_to :destinations, CoolPlaces.Destinations.Destination, foreign_key: :destination_id

    belongs_to :destination_assets, CoolPlaces.Destinations.DestinationAsset,
      foreign_key: :destination_asset_id

    timestamps(type: :utc_datetime)
  end

  # defp writeable_fields do
  #   __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at, :destination_asset_id]
  # end

  # def changeset(destination_asset_mapping, attrs) do
  #   destination_asset_mapping
  #   |> cast(attrs, writeable_fields())
  #   |> cast_assoc(:destination_assets, required: true)
  #   |> IO.inspect(label: "INSIDE MAPPING")
  # end
end
