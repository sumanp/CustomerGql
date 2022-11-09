defmodule CustomerGqlWeb.Resolvers.Preference do
  alias CustomerGql.Accounts

  def update(%{user_id: user_id} = params, _) do
    user_id = String.to_integer(user_id)

    Accounts.update_preference(user_id, Map.delete(params, :user_id))
  end
end
