defmodule FindAPlace.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :alt, :string
      add :url, :string
      add :place_id, references(:places, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:images, [:place_id])
  end
end
