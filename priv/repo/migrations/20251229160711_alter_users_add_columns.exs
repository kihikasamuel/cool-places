defmodule CoolPlaces.Repo.Migrations.AlterUsersAddColumns do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add_if_not_exists :provider, :string
      add_if_not_exists :avatar_url, :string
    end
  end

  def down do
    alter table(:users) do
      remove_if_exists :provider, :string
      remove_if_exists :avatar_url, :string
    end
  end
end
