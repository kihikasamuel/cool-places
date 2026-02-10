defmodule CoolPlaces.Repo.Migrations.CreateNewsletters do
  use Ecto.Migration

  def up do
    create table(:newsletters) do
      add :title, :citext, null: false
      add :content, :text, null: false
      add :status, :string, null: false, default: "draft"
      add :scheduled_at, :utc_datetime
      add :sent_at, :utc_datetime
      add :author_id, references(:users, type: :binary_id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create_if_not_exists index(:newsletters, [:author_id], name: :idx_newsletters_author_id)

    create table(:subscriptions) do
      add :email, :string, null: false
      add :subscribed_at, :utc_datetime, null: false
      add :unsubscribed_at, :utc_datetime
      add :status, :string, null: false
      add :type, :citext, null: false

      timestamps(type: :utc_datetime)
    end

    create_if_not_exists unique_index(:subscriptions, [:email, :type],
                           name: :uidx_subscriptions_unique_subscription_per_email_and_type
                         )

    create_if_not_exists index(:subscriptions, [:type], name: :idx_subscriptions_type)
  end

  def down do
    drop_if_exists unique_index(:subscriptions, [:email, :type],
                     name: :uidx_subscriptions_unique_subscription_per_email_and_type
                   )

    drop_if_exists index(:subscriptions, [:type], name: :idx_subscriptions_type)
    drop_if_exists index(:newsletters, [:author_id], name: :idx_newsletters_author_id)
    drop table(:subscriptions)
    drop table(:newsletters)
  end
end
