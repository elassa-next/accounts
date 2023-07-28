defmodule Accounts.MixProject do
  use Mix.Project

  def project do
    [
      app: :accounts,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:bcrypt_elixir, "~> 3.0.1"},
      {:ex_phone_number, "~> 0.4.2"}
    ]
  end
end
