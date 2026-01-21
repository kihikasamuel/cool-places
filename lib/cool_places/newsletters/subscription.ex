defmodule CoolPlaces.Newsletters.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "subscriptions" do
    field :email, :string
    field :subscribed_at, :utc_datetime
    field :unsubscribed_at, :utc_datetime
    field :status, :string, default: "subscribed"
    field :type, :string

    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, writeable_fields())
    |> subscribed_at_changeset()
    |> validate_required(writeable_fields() -- [:unsubscribed_at])
  end

  defp subscribed_at_changeset(changeset) do
    case get_field(changeset, :subscribed_at) do
      nil -> put_change(changeset, :subscribed_at, DateTime.utc_now() |> DateTime.truncate(:second))
      _ -> changeset
    end
  end
end
