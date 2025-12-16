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

  schema "destinations" do
    field :name, :string
    embeds_one :address, Address
    field :rating, :decimal
    field :status, :string

    belongs_to :country, CoolPlaces.Coutries.Country
    belongs_to :users, CoolPlaces.Accounts.User

    has_many :destination_assets, CoolPlaces.Destinations.DestinationAsset, foreign_key: :destination_id

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end

  @doc false
  def changeset(destination, attrs) do
    destination
    |> cast(attrs, writeable_fields())
    |> validate_required([])
  end
end
