defmodule CustomerGqlWeb.Schema do
  use Absinthe.Schema

  import_types CustomerGqlWeb.Types.User
  import_types CustomerGqlWeb.Types.Preference
  import_types CustomerGqlWeb.Schemas.Queries.User
  import_types CustomerGqlWeb.Schemas.Mutations.User
  import_types CustomerGqlWeb.Schemas.Mutations.Preference
  import_types CustomerGqlWeb.Schemas.Subscriptions.User
  import_types CustomerGqlWeb.Schemas.Subscriptions.Preference

  query do
    import_fields :user_queries
  end

  mutation do
    import_fields :user_mutations
    import_fields :preference_mutations
  end

  subscription do
    import_fields :user_subscriptions
    import_fields :preference_subscriptions
  end
end
