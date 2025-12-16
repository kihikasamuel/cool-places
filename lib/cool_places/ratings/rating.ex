defmodule CoolPlaces.Ratings.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    belongs_to :destination, CoolPlaces.Destinations.Destination
    belongs_to :user, CoolPlaces.Users.User
    field :value, :integer
    field :comment, :string

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, writeable_fields())
    |> validate_required([])
    |> validate_number(:value,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5,
      message: "Rating must be between 1 and 5"
    )
    |> validate_length(:comment, max: 500)
    |> unique_constraint(:user_id, name: :uidx_user_destination_rating)
  end
end
