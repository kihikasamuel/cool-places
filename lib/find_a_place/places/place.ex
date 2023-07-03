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
    has_many :places_tags, FindAPlace.Places.PlacesTags
    # many_to_many :tags, FindAPlace.Places.Tag,
    #   join_through: FindAPlace.Places.PlacesTags,
    #   on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:name, :address, :description, :cost])
    |> cast_assoc(:images, with: &FindAPlace.Places.Images.changeset/2)
    |> cast_assoc(:places_tags, with: &FindAPlace.Places.PlacesTags.changeset/2)
    |> validate_required([:name, :address, :description, :cost])
    |> validate_length(:name, min: 2, max: 100)
    # |> cast_assoc(:tags, with: &FindAPlace.Places.PlacesTags.changeset/2)
  end

  # defp parse_tags(params) do
  #   (params["tags"] || "")
  #   |> String.split(",")
  #   |> Enum.map(&String.trim/1)
  #   |> Enum.reject(& &1 == "")
  #   |> Enum.map(&get_or_insert_tag/1)
  # end

  # defp get_or_insert_tag(name) do
  #   Places.get_tag_by(name)
  #   # || Places.create_tag(%{name: name})
  # end
end
