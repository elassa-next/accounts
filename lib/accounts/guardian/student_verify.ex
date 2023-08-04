defmodule Accounts.Guardian.StudentVerify do
  use Guardian.Plug.Pipeline,
    otp_app: :accounts,
    module: Accounts.Guardian.SubjectClaims,
    error_handler: Accounts.Guardian.AuthErrorHandler

  alias Accounts.Constants

  plug Guardian.Plug.VerifyHeader, claims: %{scope: Constants.student()}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
