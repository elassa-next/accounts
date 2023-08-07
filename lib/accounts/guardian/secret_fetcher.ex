defmodule Accounts.Guardian.SecretFetcher do
  use Guardian.Token.Jwt.SecretFetcher

  def fetch_signing_secret(_module, _opts) do
    secret = fetch("private.pem")

    {:ok, secret}
  end

  def fetch_verifying_secret(_module, _headers, _opts) do
    secret = fetch("public.pem")

    {:ok, secret}
  end

  defp fetch(relative_path) do
    :code.priv_dir(Application.get_env(:accounts, :otp_app))
    |> Path.join(relative_path)
    |> JOSE.JWK.from_pem_file()
  end
end
