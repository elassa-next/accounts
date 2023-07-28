defmodule Accounts.Schema.User do
  use Ecto.Schema

  import Ecto.Changeset

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Accounts.Schema.User
    end
  end

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

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :name, :email, :phone, :image, :password, :active, :confirmed_at])
    |> validate_required([:username, :password])
    |> validate_format(:email, ~r/\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/)
    |> validate_phone(:phone)
    # |> unsafe_validate_unique([:username], Els.Repo)
    |> unique_constraint([:username])
    |> hash_password()
  end

  def super_admin_changeset(user, attrs) do
    user
    |> cast(attrs, [:super_admin])
    |> validate_required([:super_admin])
  end

  def valid_password?(%{password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  def validate_phone(changeset, field) do
    value = get_change(changeset, field)

    if value && changeset.valid? do
      with {:ok, phone} <- ExPhoneNumber.parse(value, "TR"),
           true <- ExPhoneNumber.is_valid_number?(phone) do
        changeset
      else
        _ ->
          add_error(
            changeset,
            field,
            "wrong number"
          )
      end
    else
      changeset
    end
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    if password && changeset.valid? && Mix.env() != :test do
      changeset
      |> validate_length(:password, max: 72, count: :bytes)
      |> delete_change(:password)
      |> put_change(:password, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
