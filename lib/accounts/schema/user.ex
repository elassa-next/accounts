defmodule Accounts.Schema.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Accounts.Schema.Validations

  alias Accounts.Schema.Permission.Role
  alias Accounts.Schema.Profile.Student
  alias Accounts.Schema.Profile.Teacher
  alias Accounts.Schema.Profile.Admin

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :phone, :string
    field :image, :string
    field :password, :string
    field :active, :boolean, default: true
    field :confirmed_at, :naive_datetime
    field :super_admin, :boolean, default: false

    has_one :admin, Admin, on_delete: :delete_all
    has_one :teacher, Teacher, on_delete: :delete_all
    has_one :student, Student, on_delete: :delete_all

    many_to_many :roles, Role,
      join_through: "user_roles",
      on_delete: :delete_all,
      on_replace: :delete

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :name, :email, :phone, :image, :password, :active, :confirmed_at])
    |> validate_required([:username, :password])
    |> validate_format(:email, ~r/\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/)
    |> validate_phone(:phone)
    |> unsafe_validate_unique([:username], Accounts.Repo)
    |> unique_constraint([:username])
    |> hash_password()
  end

  def super_admin_changeset(user, attrs) do
    user
    |> cast(attrs, [:super_admin])
    |> validate_required([:super_admin])
  end

  def role_changeset(role, roles, length) do
    role
    |> change()
    |> validate_equal(:role_ids, length(roles), length)
    |> put_assoc(:roles, roles)
  end

  def profile_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone, :image])
    |> validate_required([:name])
    |> validate_format(:email, ~r/\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/)
    |> validate_phone(:phone)
  end

  def valid_password?(%Accounts.Schema.User{password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    if password && changeset.valid? do
      changeset
      |> validate_length(:password, max: 72, count: :bytes)
      |> delete_change(:password)
      |> put_change(:password, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
