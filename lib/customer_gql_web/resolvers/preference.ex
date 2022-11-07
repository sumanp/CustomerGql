defmodule CustomerGqlWeb.Resolvers.Preference do
  alias CustomerGqlWeb.User

  def update(%{user_id: user_id} = params, _) do
    user_id = String.to_integer(user_id)

    User.update_preferences(user_id, params)
  end
end
