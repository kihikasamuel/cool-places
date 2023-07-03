defmodule FindAPlace.Repo.Migrations.AddPrimaryKeyToImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :id, :binary_id, primary_key: true
    end
  end
end
