defmodule Accounts.Migrations.Residence.Countries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string

      timestamps()
    end

    create unique_index(:countries, :name)
  end
end
