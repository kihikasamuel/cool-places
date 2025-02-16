defmodule FindAPlace.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query, warn: false, only: [from: 2]
  alias FindAPlace.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "currencies" do
    field :country, :string
    field :name, :string
    field :symbol, :string

    timestamps()
  end

  def changeset(currency, attr \\ %{}) do
    currency
    |> cast(attr, [:country, :name, :symbol])
    |> validate_required([:country, :name, :symbol])
    |> unique_constraint([:country, :symbol],
      name: "uidx_single_currency_symbol_per_country",
      message: "currency already exists"
    )
  end

  def create(attr) do
    __MODULE__
    |> changeset(attr)
    |> Repo.insert
  end

  def update(currency, attr) do
    currency
    |> changeset(attr)
    |> Repo.update
  end

  def get!(id) do
    from(c in Currrncy, where: id == ^id)
    |> Repo.one
  end

  def list_all do
    from(c in Currency, order_by: [desc: c.inserted_at])
    |> Repo.all
  end
end
