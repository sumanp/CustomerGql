defmodule CustomerGqlWeb.Resolvers.Preference do
  alias CustomerGql.Accounts

  def update(%{id: id} = params, _) do
    Accounts.update_preference(id, Map.delete(params, :id))
  end
end
