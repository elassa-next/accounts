defmodule Accounts.Schema.Residence.Address do
  use Ecto.Schema

  import Ecto.Changeset

  alias Accounts.Schema.Profile.Student
  alias Accounts.Schema.Profile.Teacher
  alias Accounts.Schema.Profile.Admin
  alias Accounts.Schema.Residence.City

  schema "addresses" do
    field :building_no, :string
    field :neighborhood, :string
    field :street_no, :string

    belongs_to :city, City

    has_many :admins, Admin
    has_many :teachers, Teacher
    has_many :students, Student

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:building_no, :street_no, :neighborhood, :city_id])
    |> validate_required([:neighborhood, :city_id])
    |> foreign_key_constraint(:city_id)
    |> unsafe_validate_unique([:city_id, :neighborhood], Accounts.Repo)
    |> unique_constraint([:city_id, :neighborhood])
  end
end
