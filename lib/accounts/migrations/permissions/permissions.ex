defmodule Accounts.Migrations.Permissions.Permissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :name, :string, null: false
      add :active, :boolean, default: true, null: false

      timestamps(default: fragment("NOW()"))
    end

    create unique_index(:permissions, [:name])
  end
end
