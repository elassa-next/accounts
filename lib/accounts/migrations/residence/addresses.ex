defmodule Accounts.Migrations.Residence.Addresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :building_no, :string
      add :street_no, :string
      add :neighborhood, :string
      add :city_id, references(:cities, on_delete: :nothing)

      timestamps()
    end

    create index(:addresses, [:city_id])
    create unique_index(:addresses, [:city_id, :neighborhood])
  end
end
