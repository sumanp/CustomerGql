defmodule CustomerGqlWeb.Schemas.Subscriptions.Preference do
  use Absinthe.Schema.Notation

  object :preference_subscriptions do
    field :updated_user_preferences, :preferences do
      arg :user_id, non_null(:id)

      trigger :update_user_preferences, topic: fn preferences ->
        "update_preference:#{preferences.user_id}"
      end

      config fn args, _info ->
        {:ok, topic: "update_preference:#{args.user_id}"}
      end
    end
  end
end
