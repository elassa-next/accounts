defmodule Accounts.Migrations.Profiles.Admins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :first_name, :string
      add :last_name, :string
      add :father_name, :string
      add :mother_name, :string
      add :dob, :date
      add :address_id, references(:addresses, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:admins, [:address_id])
    create unique_index(:admins, :user_id)
  end
end
