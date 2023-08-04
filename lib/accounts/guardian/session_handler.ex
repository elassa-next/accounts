defmodule ElsWeb.Guardian.SessionHandler do
  import Accounts.Changeset

  alias Accounts.Context.Users
  alias Accounts.Schema.Login
  alias Accounts.Guardian.SubjectClaims

  def login(params, scope) do
    changeset = Login.changeset(%Login{}, params)

    with {:ok, changes} <- valid_input?(changeset),
         {:ok, user} <- Users.find_user(changes, scope, true),
         {:ok, token, _claims} = SubjectClaims.encode_and_sign(user, %{scope: scope}) do
      {:ok, user, token}
    end
  end
end
