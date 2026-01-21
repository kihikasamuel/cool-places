defmodule CoolPlaces.Newsletters.Newsletter do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "newsletters" do
    field :title, :string
    field :content, :string
    field :status, :string, default: "draft"
    field :scheduled_at, :utc_datetime
    field :sent_at, :utc_datetime

    belongs_to :author, CoolPlaces.Accounts.User


    timestamps(type: :utc_datetime)
  end

  defp writeable_fields do
    __MODULE__.__schema__(:fields) -- [:id, :inserted_at, :updated_at]
  end

  @doc false
  def changeset(newsletter, attrs) do
    newsletter
    |> cast(attrs, writeable_fields())
    |> validate_required(writeable_fields())
  end
end
