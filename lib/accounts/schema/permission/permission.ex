defmodule Accounts.Schema.Permission.Permission do
  use Ecto.Schema

  import Ecto.Changeset

  alias Accounts.Schema.Permission.Role

  schema "permissions" do
    field :name, :string
    field :active, :boolean, default: true

    many_to_many :roles, Role,
      join_through: "role_permissions",
      on_delete: :delete_all,
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name, :active])
    |> validate_required([:name])
    |> unsafe_validate_unique(:name, Accounts.Repo)
    |> unique_constraint(:name)
  end
end
