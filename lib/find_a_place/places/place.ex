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
    has_many :images, FindAPlace.Places.Images
    many_to_many :tags, FindAPlace.Places.Tag,
      join_through: FindAPlace.Places.PlacesTags

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:name, :address, :description, :cost])
    |> cast_assoc(:tags, required: true)
    |> validate_required([:name, :address, :description, :cost])
    |> validate_length(:name, min: 2, max: 100)
  end
end
