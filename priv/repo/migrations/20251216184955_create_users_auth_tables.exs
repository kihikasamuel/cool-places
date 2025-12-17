defmodule CoolPlaces.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def up do
    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string

      timestamps(type: :utc_datetime, updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end

  def down do
    drop_if_exists index(:users_tokens, [:user_id])
    drop_if_exists unique_index(:users_tokens, [:context, :token])
    drop_if_exists table(:users_tokens)
  end
end
