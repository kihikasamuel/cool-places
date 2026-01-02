defmodule CoolPlaces.Destinations.Destination do
  use Ecto.Schema
  import Ecto.Changeset

  defmodule Address do
    use Ecto.Schema

    embedded_schema do
      field :street, :string
      field :town, :string
      field :city, :string
      field :postal_code, :string
      # {lat: -1.207419663745757, long: 36.8588036290915}
      field :coordinates, :map
    end

    def changeset(address, attrs) do
      address
      |> cast(attrs, [:street, :town, :city, :postal_code, :coordinates])
    end
  end

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "destinations" do
    field :name, :string
    embeds_one :address, Address

    ## TODO: drop and change to virtual field, that takes the average ratings from the ratings table
    field :rating, :decimal
    ## for the purpose of delisting
    field :status, :string
    field :description, :string, virtual: true
    ## TODO: add tags module and reference it here or use information as pulled from maps
    field :tag, :string, virtual: true

    belongs_to :country, CoolPlaces.Countries.Country
    belongs_to :users, CoolPlaces.Accounts.User

    many_to_many :destination_assets, CoolPlaces.Destinations.DestinationAsset,
      join_through: CoolPlaces.Destinations.DestinationAssetMapping

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at, :address]
  end

  @doc false
  def changeset(destination, attrs) do
    destination
    |> cast(attrs, writeable_fields())
    |> cast_assoc(:destination_assets, required: true)
    |> validate_required([])
    # |> maybe_cast_destination_assets(attrs)

    # |> cast_embed(:address, with: &Address.changeset/2, required: true)
  end
end
