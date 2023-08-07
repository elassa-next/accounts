defmodule Accounts.Policy.Profile.ProfilePolicy do
  @behaviour Bodyguard.Policy

  # User own the profile can do the action
  def authorize(_action, %{id: user_id}, %{"id" => user_id}), do: :ok

  # Otherwise, denied
  def authorize(_action, _user, _params), do: :error
end
