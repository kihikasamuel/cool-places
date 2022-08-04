defmodule FindAPlace.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "places" do
    field :address, :string
    field :cost, :decimal
    field :description, :string
    field :name, :string

    has_many :likes, FindAPlace.Places.Like

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:name, :address, :description, :cost])
    |> validate_required([:name, :address, :description, :cost])
    |> validate_length(:name, min: 2, max: 100)
  end
end
