defmodule Accounts.Schema.Residence.State do
  use Ecto.Schema

  import Ecto.Changeset

  alias Accounts.Schema.Residence.City
  alias Accounts.Schema.Residence.Country

  schema "states" do
    field :name, :string

    belongs_to :country, Country
    has_many :cities, City

    timestamps()
  end

  @doc false
  def changeset(province, attrs) do
    province
    |> cast(attrs, [:name, :country_id])
    |> validate_required([:name, :country_id])
    |> foreign_key_constraint(:country_id)
    |> unsafe_validate_unique([:country_id, :name], Accounts.Repo)
    |> unique_constraint([:country_id, :name])
  end
end
