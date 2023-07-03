defmodule FindAPlace.Repo.Migrations.ModifyPlacesDescription do
  use Ecto.Migration

  def change do
    alter table(:places) do
      modify :description, :text
    end
  end
end
