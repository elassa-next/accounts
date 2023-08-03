defmodule Accounts.Context.Profiles.Students do
  import Ecto.Query, warn: false

  alias Accounts.Repo
  alias Accounts.Constants
  alias Accounts.Schema.Profile.Student

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students do
    Repo.all(Student)
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)

  def get_student_by_user!(user_id) do
    from(
      t in Student,
      where: t.user_id == ^user_id,
      limit: 1
    )
    |> Repo.one!()
  end

  def get_full_student!(id) do
    from(
      a in Student,
      preload: [user: :roles]
    )
    |> Repo.get!(id)
  end

  def get_full_student_by_user!(user_id) do
    from(
      t in Student,
      where: t.user_id == ^user_id,
      preload: [:user],
      limit: 1
    )
    |> Repo.one!()
  end

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.update_changeset(attrs)
    |> Repo.update()
  end

  def profile_student(%Student{} = student, attrs) do
    student
    |> Student.profile_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.transaction(fn repo ->
      repo.delete(student)

      from(
        ur in "user_roles",
        join: r in Role,
        on: r.id == ur.role_id,
        where: r.scope == ^Constants.student(),
        where: ur.user_id == ^student.user_id
      )
      |> repo.delete_all()
    end)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.create_changeset(student, attrs)
  end
end
