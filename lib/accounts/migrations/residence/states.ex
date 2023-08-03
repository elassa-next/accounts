defmodule Accounts.Migrations.Residence.States do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :name, :string
      add :country_id, references(:countries, on_delete: :nothing)

      timestamps()
    end

    create index(:states, [:country_id])
    create unique_index(:states, [:country_id, :name])
  end
end
