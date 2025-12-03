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

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [])
    |> validate_required([])
  end
end
