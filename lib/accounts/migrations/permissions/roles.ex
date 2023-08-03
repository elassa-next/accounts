defmodule Accounts.Migrations.Permissions.Roles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string, null: false
      add :active, :boolean, default: true, null: false
      add :scope, :string, null: false

      timestamps(default: fragment("NOW()"))
    end

    create unique_index(:roles, [:name])
  end
end
