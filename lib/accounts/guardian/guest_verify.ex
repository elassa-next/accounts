defmodule Accounts.Guardian.GuestVerify do
  use Guardian.Plug.Pipeline,
    otp_app: Application.get_env(:accounts, :otp_app),
    module: Accounts.Guardian.SubjectClaims,
    error_handler: Accounts.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureNotAuthenticated
end
