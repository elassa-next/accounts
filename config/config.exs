import Config

config :accounts, Accounts.Guardian.SubjectClaims,
  issuer: "accounts",
  allowed_algos: ["RS512"],
  secret_fetcher: Accounts.Guardian.SecretFetcher
