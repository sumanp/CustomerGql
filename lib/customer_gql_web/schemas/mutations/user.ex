defmodule CustomerGqlWeb.Schemas.Mutations.User do
  use Absinthe.Schema.Notation
  alias CustomerGqlWeb.Resolvers

  object :user_mutations do
    field :update_user, :user do
      arg :id, non_null(:id)
      arg :name, :string
      arg :email, :string
      arg :preference, :preferences_input

      resolve &Resolvers.User.update/2
    end

    field :create_user, :user do
      arg :name, :string
      arg :email, :string
      arg :preference, :preferences_input

      resolve &Resolvers.User.create/2
    end
  end
end
