defmodule FindAPlace.Places.Like do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "likes" do
    field :vote, :integer

    belongs_to :place, FindAPlace.Places.Place
    # belongs_to :user, FindAPlace.Users.User
    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:vote, :place_id])
    |> validate_required([:vote, :place_id])
  end
end
