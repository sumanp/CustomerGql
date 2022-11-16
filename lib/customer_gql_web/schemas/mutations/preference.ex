defmodule CustomerGqlWeb.Schemas.Mutations.Preference do
  use Absinthe.Schema.Notation
  alias CustomerGqlWeb.Resolvers

  object :preference_mutations do
    field :update_user_preferences, :preference do
      arg :user_id, non_null(:id)
      arg :id, non_null(:id)
      arg :likes_emails, :boolean
      arg :likes_phone_calls, :boolean
      arg :likes_faxes, :boolean

      resolve(&Resolvers.Preference.update/2)
    end
  end
end
