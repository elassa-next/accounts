defmodule Accounts.Schema.Permission.Role do
  use Ecto.Schema

  import Ecto.Changeset
  import Accounts.Schema.Validations

  alias Accounts.Schema.User
  alias Accounts.Schema.Permission.Permission
  alias Accounts.Constants

  schema "roles" do
    field :active, :boolean, default: true
    field :name, :string
    field :scope, :string

    many_to_many :permissions, Permission,
      join_through: "role_permissions",
      on_delete: :delete_all,
      on_replace: :delete

    many_to_many :users, User,
      join_through: "user_roles",
      on_delete: :delete_all,
      on_replace: :delete

    timestamps()
  end

  @doc false
  def create_changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :active, :scope])
    |> validate_required([:name, :scope])
    |> validate_inclusion(:scope, Constants.scopes())
    |> unsafe_validate_unique(:name, Accounts.Repo)
    |> unique_constraint(:name)
  end

  def update_changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :active])
    |> validate_required([:name])
    |> unsafe_validate_unique(:name, Accounts.Repo)
    |> unique_constraint(:name)
  end

  def permission_changeset(role, permissions, length) do
    role
    |> change()
    |> validate_equal(:role_ids, length(permissions), length)
    |> put_assoc(:permissions, permissions)
  end
end
