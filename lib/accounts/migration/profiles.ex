defmodule Accounts.Migration.Profiles do
  use Ecto.Migration

  def change(table_name \\ :profiles) do
    create table(table_name) do
      add :first_name, :string
      add :last_name, :string
      add :father_name, :string
      add :mother_name, :string
      add :dob, :date
      add :address_id, references(:addresses, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(table_name, [:address_id])
    create unique_index(table_name, :user_id)
  end
end
