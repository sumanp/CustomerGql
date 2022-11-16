defmodule CustomerGqlWeb.Resolvers.User do
  alias CustomerGql.Accounts

  def all(params, _), do: {:ok, Accounts.list_users(params)}

  def find(%{id: id}, _) do
    Accounts.find_user(%{id: id})
  end

  def update(%{id: id} = params, _) do
    Accounts.update_user(id, params)
  end

  def create(params, _) do
    case Accounts.create_user(params) do
      {:ok, user} -> {:ok, user}
      error -> error
    end
  end
end
