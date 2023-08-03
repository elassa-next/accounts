defmodule Accounts.Schema.Validations do
  import Ecto.Changeset

  def validate_equal(changeset, field, left, right) do
    if left == right do
      changeset
    else
      add_error(
        changeset,
        field,
        "not equal"
      )
    end
  end

  def validate_phone(changeset, field) do
    value = get_change(changeset, field)

    if value && changeset.valid? do
      with {:ok, phone} <- ExPhoneNumber.parse(value, "TR"),
           true <- ExPhoneNumber.is_valid_number?(phone) do
        changeset
      else
        _ ->
          add_error(
            changeset,
            field,
            "wrong number"
          )
      end
    else
      changeset
    end
  end
end
