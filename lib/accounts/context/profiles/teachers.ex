defmodule Accounts.Context.Profiles.Teachers do
  import Ecto.Query, warn: false

  alias Accounts.Repo
  alias Accounts.Constants
  alias Accounts.Schema.Profile.Teacher

  @doc """
  Returns the list of teachers.

  ## Examples

      iex> list_teachers()
      [%Teacher{}, ...]

  """
  def list_teachers do
    Repo.all(Teacher)
  end

  @doc """
  Gets a single teacher.

  Raises `Ecto.NoResultsError` if the Teacher does not exist.

  ## Examples

      iex> get_teacher!(123)
      %Teacher{}

      iex> get_teacher!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teacher!(id), do: Repo.get!(Teacher, id)

  def get_teacher_by_user!(user_id) do
    from(
      s in Teacher,
      where: s.user_id == ^user_id,
      limit: 1
    )
    |> Repo.one!()
  end

  def get_full_teacher!(id) do
    from(
      a in Teacher,
      preload: [user: :roles]
    )
    |> Repo.get!(id)
  end

  def get_full_teacher_by_user!(user_id) do
    from(
      s in Teacher,
      where: s.user_id == ^user_id,
      preload: [:user],
      limit: 1
    )
    |> Repo.one!()
  end

  @doc """
  Creates a teacher.

  ## Examples

      iex> create_teacher(%{field: value})
      {:ok, %Teacher{}}

      iex> create_teacher(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teacher(attrs \\ %{}) do
    %Teacher{}
    |> Teacher.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teacher.

  ## Examples

      iex> update_teacher(teacher, %{field: new_value})
      {:ok, %Teacher{}}

      iex> update_teacher(teacher, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teacher(%Teacher{} = teacher, attrs) do
    teacher
    |> Teacher.update_changeset(attrs)
    |> Repo.update()
  end

  def profile_teacher(%Teacher{} = teacher, attrs) do
    teacher
    |> Teacher.profile_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a teacher.

  ## Examples

      iex> delete_teacher(teacher)
      {:ok, %Teacher{}}

      iex> delete_teacher(teacher)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teacher(%Teacher{} = teacher) do
    Repo.transaction(fn repo ->
      repo.delete(teacher)

      from(
        ur in "user_roles",
        join: r in Role,
        on: r.id == ur.role_id,
        where: r.scope == ^Constants.teacher(),
        where: ur.user_id == ^teacher.user_id
      )
      |> repo.delete_all()
    end)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teacher changes.

  ## Examples

      iex> change_teacher(teacher)
      %Ecto.Changeset{data: %Teacher{}}

  """
  def change_teacher(%Teacher{} = teacher, attrs \\ %{}) do
    Teacher.create_changeset(teacher, attrs)
  end
end
