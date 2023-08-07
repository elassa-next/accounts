defmodule Accounts.Context.Profiles.Admins do
  import Ecto.Query, warn: false

  alias Accounts.Schema.Permission.Role
  alias Accounts.Repo
  alias Accounts.Constants
  alias Accounts.Schema.Profile.Admin

  @doc """
  Returns the list of admins.

  ## Examples

      iex> list_admins()
      [%Admin{}, ...]

  """
  def list_admins do
    Repo.all(Admin)
  end

  @doc """
  Gets a single admin.

  Raises `Ecto.NoResultsError` if the Admin does not exist.

  ## Examples

      iex> get_admin!(123)
      %Admin{}

      iex> get_admin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admin!(id), do: Repo.get!(Admin, id)

  def get_admin_by_user!(user_id) do
    from(
      a in Admin,
      where: a.user_id == ^user_id,
      limit: 1
    )
    |> Repo.one!()
  end

  def get_full_admin!(id) do
    from(
      a in Admin,
      preload: [user: :roles]
    )
    |> Repo.get!(id)
  end

  def get_full_admin_by_user!(user_id) do
    from(
      a in Admin,
      where: a.user_id == ^user_id,
      preload: [:user],
      limit: 1
    )
    |> Repo.one!()
  end

  @doc """
  Creates a admin.

  ## Examples

      iex> create_admin(%{field: value})
      {:ok, %Admin{}}

      iex> create_admin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admin(attrs \\ %{}) do
    %Admin{}
    |> Admin.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admin.

  ## Examples

      iex> update_admin(admin, %{field: new_value})
      {:ok, %Admin{}}

      iex> update_admin(admin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.update_changeset(attrs)
    |> Repo.update()
  end

  def profile_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.profile_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a admin.

  ## Examples

      iex> delete_admin(admin)
      {:ok, %Admin{}}

      iex> delete_admin(admin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admin(%Admin{} = admin) do
    Repo.transaction(fn repo ->
      repo.delete(admin)

      from(
        ur in "user_roles",
        join: r in Role,
        on: r.id == ur.role_id,
        where: r.scope == ^Constants.admin(),
        where: ur.user_id == ^admin.user_id
      )
      |> repo.delete_all()
    end)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admin changes.

  ## Examples

      iex> change_admin(admin)
      %Ecto.Changeset{data: %Admin{}}

  """
  def change_admin(%Admin{} = admin, attrs \\ %{}) do
    Admin.create_changeset(admin, attrs)
  end
end
