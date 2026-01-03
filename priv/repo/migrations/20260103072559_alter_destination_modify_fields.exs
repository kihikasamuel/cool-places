defmodule CoolPlaces.Repo.Migrations.AlterDestinationModifyFields do
  use Ecto.Migration

  def up do
    alter table(:destinations) do
      remove_if_exists :rating, :decimal
      add_if_not_exists :description, :text
      add_if_not_exists :tag, :string
    end
  end

  def down do
    alter table(:destinations) do
      add_if_not_exists :rating, :decimal
      remove_if_exists :description, :text
    end
  end
end
