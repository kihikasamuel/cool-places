defmodule CoolPlaces.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :email, :string
      add :msisdn, :string
      add :name, :citext
      add :password, :string
      add :hashed_password, :string
      add :confirmed_at, :utc_datetime
      add :country_of_residence_id, references(:countries, on_delete: :nothing, type: :binary_id)
      add :status, :string

      timestamps(type: :utc_datetime)
    end

    create_if_not_exists unique_index(:users, [:email], name: :uidx_users_email)
  end

  def down do
    drop_if_exists unique_index(:users, [:email], name: :uidx_users_email)
    drop_if_exists table(:users)
  end
end
