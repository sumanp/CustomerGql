defmodule CustomerGqlWeb.Types.User do
  use Absinthe.Schema.Notation

  input_object :preferences_input do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :likes_faxes, :boolean
  end

  object :user_preferences do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :likes_faxes, :boolean
  end

  @desc "User with preferences"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :preferences, :user_preferences
  end
end
