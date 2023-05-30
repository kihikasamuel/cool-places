defmodule FindAPlace.Places.PlacesTags do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "places_tags" do
    belongs_to :place, FindAPlace.Places.Place
    belongs_to :tags, FindAPlace.Places.Tag

    timestamps()
  end

  @doc false
  def changeset(place_tags, attrs) do
    place_tags
    |> cast(attrs, [])
    |> validate_required([])
  end
end
