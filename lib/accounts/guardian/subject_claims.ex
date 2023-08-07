defmodule Accounts.Guardian.SubjectClaims do
  use Guardian,
    otp_app: Application.get_env(:accounts, :otp_app)

  alias Accounts.Context.Users

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id, "scope" => scope}) do
    user = Users.get_user!(id)

    {:ok, %{id: id, scope: scope, super_admin: user.super_admin}}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
