defmodule FindAPlace.Places.Images do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "images" do
    field :alt, :string
    field :url, :string

    belongs_to :place, FindAPlace.Places.Place

    timestamps()
  end

  @doc false
  def changeset(images, attrs) do
    images
    |> cast(attrs, [:alt, :url])
    |> validate_required([:alt, :url])
  end
end
