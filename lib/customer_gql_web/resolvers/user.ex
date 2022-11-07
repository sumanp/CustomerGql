defmodule CustomerGqlWeb.Resolvers.User do
  alias CustomerGqlWeb.User

  def all(params, _), do: User.all(params)

  def find(%{id: id}, _) do
    id = String.to_integer(id)

    User.find(%{id: id})
  end

  def update(%{id: id} = params, _) do
    id = String.to_integer(id)

    User.update(id, Map.delete(params, :id))
  end

  def create(%{id: id} = params, _) do
    id = String.to_integer(id)

    with {:ok, user} <- User.create(Map.put(params, :id, id)) do
      {:ok, user}
    else
      error -> error
    end
  end
end
