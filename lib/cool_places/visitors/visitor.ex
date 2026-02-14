defmodule CoolPlaces.Visitors.Visitor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "visitors" do
    field :ip_address_hash, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :city, :string
    field :region, :string
    field :country, :string
    field :country_code, :string
    field :timezone, :string
    field :user_agent, :string
    field :visited_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end

  @doc false
  def changeset(visitor, attrs) do
    visitor
    |> cast(attrs, writeable_fields())
    |> validate_required([:latitude, :longitude, :country, :country_code, :visited_at])
  end
end
