defmodule Accounts.Migrations.Users do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :username, :citext, null: false
      add :name, :string
      add :email, :string
      add :phone, :string
      add :image, :string
      add :password, :string
      add :confirmed_at, :naive_datetime
      add :active, :boolean, default: true, null: false
      add :super_admin, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, :username)
  end
end
