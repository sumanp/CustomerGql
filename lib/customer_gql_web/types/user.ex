defmodule CustomerGqlWeb.Types.User do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  input_object :preferences_input do
    field :id, :id
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :likes_faxes, :boolean
  end

  @desc "User with preferences"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :preference, :preference, resolve: dataloader(CustomerGql.Accounts, :preference)
  end
end
