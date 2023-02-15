defmodule CustomerGqlWeb.Resolvers.Analytics do
  alias CustomerGql.Accounts

  def find(%{key: key}, _) do
    Accounts.find_resolver_hit(%{key: key})
  end
end
