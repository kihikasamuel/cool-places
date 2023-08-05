defmodule FindAPlace.Places.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tags" do
    field :name, :string
    # many_to_many :places, FindAPlace.Places.Place,
    # join_through: FindAPlace.Places.PlacesTags

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> lower_case()
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  defp lower_case(changeset) do
    name = get_field(changeset, :name)

    changeset
    |> put_change(:name, String.downcase(name))
  end
end
