defmodule FindAPlace.Repo.Migrations.CreateTableCurrencies do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:currencies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :country, :string
      add :symbol, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:currencies, [:country, :symbol], name: "uidx_single_currency_symbol_per_country")
  end
end
