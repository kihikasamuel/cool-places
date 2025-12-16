defmodule CoolPlaces.Destinations.DestinationAsset do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  schema "destination_assets" do
    belongs_to :destination, CoolPlaces.Destinations.Destination
    field :is_destination_cover?, :boolean, default: false
    field :asset_type, :string, default: "image"
    field :asset_url, CoolPlaces.Uploads.Type

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at, :asset_url]
  end

  @doc false
  def changeset(destination_asset, attrs) do
    destination_asset
    |> cast(attrs, writeable_fields())
    |> validate_required([])
    |> cast_attachments(attrs, [:asset_url], allow_paths: true)
  end
end
