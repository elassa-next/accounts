defmodule Accounts.Filter do
  def optional(query, field, filter) do
    if not is_nil(field) do
      filter.(query)
    else
      query
    end
  end
end
