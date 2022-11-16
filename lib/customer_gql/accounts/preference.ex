defmodule CustomerGql.Accounts.Preference do
  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field :likes_emails, :boolean, default: false
    field :likes_faxes, :boolean, default: false
    field :likes_phone_calls, :boolean, default: false

    belongs_to :user, CustomerGql.Accounts.User
  end

  @available_params [:likes_emails, :likes_phone_calls, :likes_faxes]

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, @available_params)
    |> validate_required(@available_params)
  end
end
