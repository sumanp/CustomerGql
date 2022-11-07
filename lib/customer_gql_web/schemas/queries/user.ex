defmodule CustomerGqlWeb.Schemas.Queries.User do
  use Absinthe.Schema.Notation
  alias CustomerGqlWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)

      resolve &Resolvers.User.find/2
    end

    field :users, list_of(:user) do
      arg :likes_emails, :boolean
      arg :likes_phone_calls, :boolean
      arg :likes_faxes, :boolean

      resolve &Resolvers.User.all/2
    end
  end
end
