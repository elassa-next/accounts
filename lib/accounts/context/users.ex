defmodule Accounts.Context.Users do
  import Ecto.Query, warn: false

  alias Accounts.Schema.Permission.Role
  alias Accounts.Repo
  alias Accounts.Schema.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by id, username, password from a specific scope.

  ## Examples

      iex> find_user(%{username: "admin", password: "123"}, "admin")
      {:ok, %User{}}

      iex> find_user(%{username: "student", password: "123"}, "admin")
      {:error, message}

  """
  def find_user(params, scope \\ nil, active \\ nil)

  def find_user(%{username: username, password: password}, scope, active) do
    query =
      from(u in User, where: u.username == ^username)
      |> find_user_optional_params(scope, active)

    with user <- Repo.one(query),
         true <- User.valid_password?(user, password) do
      {:ok, user}
    else
      _ -> {:error, :bad_credentials}
    end
  end

  def find_user(%{id: id}, scope, active) do
    query =
      from(u in User, where: u.id == ^id)
      |> find_user_optional_params(scope, active)

    with %User{} = user <- Repo.one(query) do
      {:ok, user}
    else
      _ -> {:error, :not_found}
    end
  end

  defp find_user_optional_params(query, scope, active) do
    query =
      if not is_nil(scope) do
        join(query, :inner, [u], p in ^scope, on: u.id == p.user_id)
      end

    query =
      if not is_nil(active) do
        where(query, [u], u.active == ^active)
      end

    query
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def change_super_admin(user_id, super_admin \\ false) do
    User
    |> Repo.get!(user_id)
    |> User.super_admin_changeset(%{super_admin: super_admin})
    |> Repo.update()
  end

  def assign_roles(%User{} = user, scope, role_ids \\ []) do
    roles = Repo.all(from(r in Role, where: r.id in ^role_ids, where: r.scope == ^scope))

    user
    |> Repo.preload(roles: from(r in Role, where: r.scope == ^scope))
    |> User.role_changeset(roles, length(role_ids))
    |> Repo.update()
  end

  def user_can?(user_id, scope, permission) do
    from(
      u in User,
      join: r in assoc(u, :roles),
      join: p in assoc(r, :permissions),
      where: u.active == true,
      where: u.id == ^user_id,
      where: r.active == true,
      where: r.scope == ^scope,
      where: p.active == true,
      where: p.name == ^permission,
      select: 1
    )
    |> Repo.exists?()
  end
end
