defmodule CustomerGqlWeb.Schemas.Mutations.PreferenceTest do
  use CustomerGql.DataCase, async: true

  alias CustomerGqlWeb.Schema
  alias CustomerGql.Accounts

  @update_preference_doc """
  mutation UpdateUserPreferences($id: ID!, $user_id: ID!, $likes_emails: Boolean, $likes_phone_calls: Boolean, $likes_faxes: Boolean) {
    updateUserPreferences(id: $id, user_id: $user_id, likes_emails: $likes_emails, likes_phone_calls:  $likes_phone_calls, likes_faxes: $likes_faxes) {
      id
      user_id
      likes_emails
      likes_phone_calls
      likes_faxes
    }
  }
  """

  describe "@updateUserPreferences" do
    test "updates user preference by id" do
      assert {:ok, user} =
               Accounts.create_user(%{
                 name: "name 1",
                 email: "name1@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phone_calls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, %{data: _data}} =
               Absinthe.run(@update_preference_doc, Schema,
                 variables: %{
                   "user_id" => user.id,
                   "id" => user.preference.id,
                   "likes_emails" => false
                 }
               )

      assert {:ok, user_1} = Accounts.find_user(%{id: user.id, preload: [:preference]})
      assert user_1.preference.likes_emails === false
    end
  end
end
