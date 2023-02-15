defmodule CustomerGqlWeb.Schemas.Queries.Analytics do
  use Absinthe.Schema.Notation
  alias CustomerGqlWeb.Resolvers

  object :resolver_queries do
    field :resolver_hits, :hits do
      arg :key, non_null(:string)

      resolve &Resolvers.Analytics.find/2
    end
  end
end
