defmodule FindAPlace.Repo.Migrations.CreatePlacesTags do
  use Ecto.Migration

  def change do
    create table(:places_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :place_id, references(:places, on_delete: :nothing, type: :binary_id)
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:places_tags, [:place_id])
    create index(:places_tags, [:tag_id])
  end
end
