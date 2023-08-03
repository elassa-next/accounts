defmodule Accounts.Schema.Profile.Admin do
  use Ecto.Schema

  import Ecto.Changeset

  alias Accounts.Schema.User
  alias Accounts.Schema.Residence.Address

  schema "admins" do
    field :dob, :date
    field :father_name, :string
    field :first_name, :string
    field :last_name, :string
    field :mother_name, :string

    belongs_to :user, User
    belongs_to :address, Address

    timestamps()
  end

  @doc false
  def create_changeset(admin, attrs) do
    admin
    |> cast(attrs, [
      :first_name,
      :last_name,
      :father_name,
      :mother_name,
      :dob,
      :user_id,
      :address_id
    ])
    |> validate_required([:first_name, :last_name, :dob, :address_id, :user_id])
    |> unsafe_validate_unique([:user_id], Accounts.Repo)
    |> unique_constraint([:user_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:address_id)
  end

  def update_changeset(admin, attrs) do
    admin
    |> cast(attrs, [:first_name, :last_name, :father_name, :mother_name, :dob, :address_id])
    |> validate_required([:first_name, :last_name, :dob, :address_id])
    |> foreign_key_constraint(:address_id)
  end

  def profile_changeset(admin, attrs) do
    admin
    |> cast(attrs, [:first_name, :last_name, :father_name, :mother_name, :dob])
    |> validate_required([:first_name, :last_name, :dob])
    |> cast_assoc(:user, on_replace: :nothing, with: &User.profile_changeset/2)
  end
end
