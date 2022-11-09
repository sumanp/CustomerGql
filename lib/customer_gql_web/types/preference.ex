defmodule CustomerGqlWeb.Types.Preference do
  use Absinthe.Schema.Notation

  @desc "User preferences"
  object :preference do
    field(:user_id, non_null(:id))
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end
end
