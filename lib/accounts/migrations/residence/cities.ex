defmodule Accounts.Migrations.Residence.Cities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string
      add :state_id, references(:states, on_delete: :nothing)

      timestamps()
    end

    create index(:cities, [:state_id])
    create unique_index(:cities, [:state_id, :name])
  end
end
