defmodule Accounts.Context.Permissions.Roles do
  import Ecto.Query, warn: false

  alias Accounts.Repo
  alias Accounts.Schema.Permission.Role
  alias Accounts.Schema.Permission.Permission

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  def list_roles_with_permissions do
    from(
      r in Role,
      preload: :permissions
    )
    |> Repo.all()
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  def get_role_with_permissions!(id) do
    from(
      r in Role,
      preload: :permissions
    )
    |> Repo.get!(id)
  end

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.create_changeset(role, attrs)
  end

  def assign_permissions(%Role{} = role, permission_ids \\ []) do
    permissions = Repo.all(from(p in Permission, where: p.id in ^permission_ids))

    role
    |> Repo.preload(:permissions)
    |> Role.permission_changeset(permissions, length(permission_ids))
    |> Repo.update()
  end
end
