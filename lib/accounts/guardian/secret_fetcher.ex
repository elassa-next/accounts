defmodule Accounts.Guardian.SecretFetcher do
  use Guardian.Token.Jwt.SecretFetcher

  def fetch_signing_secret(_module, _opts) do
    secret =
      "private.pem"
      |> fetch()

    {:ok, secret}
  end

  def fetch_verifying_secret(_module, _headers, _opts) do
    secret =
      "public.pem"
      |> fetch()

    {:ok, secret}
  end

  defp fetch(relative_path) do
    :code.priv_dir(:accounts)
    |> Path.join(relative_path)
    |> JOSE.JWK.from_pem_file()
  end
end
