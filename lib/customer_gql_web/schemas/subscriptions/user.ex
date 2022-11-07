defmodule CustomerGqlWeb.Schemas.Subscriptions.User do
  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :created_user, :user do
      trigger :create_user, topic: fn _ ->
        "new_user"
      end

      config fn _args, _info ->
        {:ok, topic: "new_user"}
      end
    end
  end
end
