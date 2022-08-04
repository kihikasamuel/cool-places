defmodule FindAPlace.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :address, :string, null: false
      add :description, :string
      add :cost, :decimal, precision: 15, scale: 6, null: false

      timestamps()
    end
  end
end
