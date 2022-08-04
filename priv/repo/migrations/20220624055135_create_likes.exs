defmodule FindAPlace.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :vote, :integer
      add :place_id, references(:places, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:likes, [:place_id])
  end
end
