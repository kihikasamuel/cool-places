defmodule CoolPlaces.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def up do
    create table(:ratings) do
      add :destination_id, references(:destinations, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :value, :integer
      add :comment, :text

      timestamps(type: :utc_datetime)
    end

    create_if_not_exists index(:ratings, [:destination_id])
    create_if_not_exists index(:ratings, [:user_id])
    create_if_not_exists unique_index(:ratings, [:user_id, :destination_id], name: :uidx_user_destination_rating)
  end

  def down do
    drop_if_exists index(:ratings, [:user_id, :destination_id], name: :uidx_user_destination_rating)
    drop_if_exists index(:ratings, [:user_id])
    drop_if_exists index(:ratings, [:destination_id])
    drop_if_exists table(:ratings)
  end
end
