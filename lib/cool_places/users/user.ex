defmodule CoolPlaces.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :msisdn, :string
    field :name, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :confirmed_at, :utc_datetime
    field :status, :string

    belongs_to :country_of_residence, CoolPlaces.Coutries.Country, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  def writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, writeable_fields())
    |> validate_required([])
  end
end
