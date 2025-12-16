defmodule CoolPlaces.Coutries.Country do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "countries" do
    field :name, :string
    field :code, :string
    field :emoji, :string
    field :dial_code, :string
    field :unicode_char, :string

    has_many :users, CoolPlaces.Users.User, foreign_key: :country_of_residence_id
    has_many :destinations, CoolPlaces.Destinations.Destination

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end
  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, writeable_fields())
    |> validate_required([])
  end
end
