defmodule Accounts.Migration.Residence do
  use Ecto.Migration

  def change do
    ### COUNTRIES ###
    create table(:countries) do
      add :name, :string

      timestamps()
    end

    create(unique_index(:countries, :name))

    ### PROVINCES ###
    create table(:provinces) do
      add :name, :string
      add :country_id, references(:countries, on_delete: :nothing)

      timestamps()
    end

    create index(:provinces, [:country_id])
    create unique_index(:provinces, [:country_id, :name])

    ### REGIONS ###
    create table(:regions) do
      add :name, :string
      add :province_id, references(:provinces, on_delete: :nothing)

      timestamps()
    end

    create index(:regions, [:province_id])
    create unique_index(:regions, [:province_id, :name])

    ### DISTRICTS ###
    create table(:districts) do
      add :name, :string
      add :region_id, references(:regions, on_delete: :nothing)

      timestamps()
    end

    create index(:districts, [:region_id])
    create unique_index(:districts, [:region_id, :name])

    ### CITIES ###
    create table(:cities) do
      add :name, :string
      add :district_id, references(:districts, on_delete: :nothing)

      timestamps()
    end

    create index(:cities, [:district_id])
    create unique_index(:cities, [:district_id, :name])

    ### ADDRESSES ###
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
