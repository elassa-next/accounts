defmodule Accounts.Constants do
  ### User Scopes
  def admin, do: "admins"
  def teacher, do: "teachers"
  def student, do: "students"
  def scopes, do: ["admins", "teachers", "students"]
end
