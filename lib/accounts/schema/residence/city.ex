defmodule Accounts.Schema.Residence.City do
  use Ecto.Schema

  import Ecto.Changeset

  alias Accounts.Schema.Residence.Address
  alias Accounts.Schema.Residence.State

  schema "cities" do
    field :name, :string

    belongs_to :state, State
    has_many :addresses, Address

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :state_id])
    |> validate_required([:name, :state_id])
    |> foreign_key_constraint(:state_id)
    |> unsafe_validate_unique([:state_id, :name], Accounts.Repo)
    |> unique_constraint([:state_id, :name])
  end
end
