defmodule Accounts.Repo do
  use Ecto.Repo,
    otp_app: Application.compile_env(:accounts, :otp_app),
    adapter: Ecto.Adapters.Postgres
end
