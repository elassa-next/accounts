defmodule Accounts.Policy.Profile.TeacherPolicy do
  @behaviour Bodyguard.Policy

  import Accounts.Context.Users, only: [user_can?: 3]

  # Super Admins can do anything
  def authorize(_action, %{super_admin: true}, _params), do: :ok

  # User with active permission can do the action
  def authorize(action, %{id: user_id, scope: scope}, _params) do
    user_can?(user_id, scope, "profiles_teacher_#{action}")
  end

  # Otherwise, denied
  def authorize(_action, _user, _params), do: :error
end
