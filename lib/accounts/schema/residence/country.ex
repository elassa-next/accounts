defmodule Accounts.Schema.Residence.Country do
  use Ecto.Schema

  import Ecto.Changeset

  alias Accounts.Schema.Residence.State

  schema "countries" do
    field :name, :string

    has_many :states, State

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unsafe_validate_unique([:name], Accounts.Repo)
    |> unique_constraint([:name])
  end
end
