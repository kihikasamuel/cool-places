defmodule CoolPlaces.Destinations.DestinationAsset do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "destination_assets" do
    field :is_destination_cover?, :boolean, default: false
    field :asset_type, :string, default: "image"
    field :asset_url, CoolPlaces.Utils.Uploads.Type

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end

  @doc false
  def changeset(destination_asset, attrs) do
    destination_asset
    |> cast(attrs, writeable_fields())
    |> cast_attachments(attrs, [:asset_url])
  end
end
