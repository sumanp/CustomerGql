defmodule CustomerGqlWeb.Resolvers.User do
  alias CustomerGql.Accounts

  def all(params, _), do: {:ok, Accounts.list_users(params)}

  def find(%{id: id}, _) do
    id = String.to_integer(id)

    Accounts.find_user(%{id: id})
  end

  def update(%{id: id} = params, _) do
    id = String.to_integer(id)

    Accounts.update_user(id, Map.delete(params, :id))
  end

  def create(params, _) do
    with {:ok, user} <- Accounts.create_user(params) do
      {:ok, user}
    else
      error -> error
    end
  end
end
