defmodule CustomerGqlWeb.Subscriptions.PreferenceTest do
  use CustomerGql.SubscriptionCase

  alias CustomerGql.Accounts

  @update_user_pref_doc """
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

  @updated_user_pref_sub_doc """
  subscription UpdatedUserPreferences($user_id: ID!, $id: ID!) {
    updatedUserPreferences(user_id: $user_id, id: $id) {
      id
      user_id
      likes_emails
    }
  }
  """

  describe "@userPreferencesUpdated" do
    test "sends a user when @updateUserPreferences mutation is triggered", %{socket: socket} do
      assert {:ok, user} =
               Accounts.create_user(%{
                 name: "name 1",
                 email: "name1@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 },
                 preload: [:preference]
               })

      user_id = to_string(user.id)
      pref_id = to_string(user.preference.id)
      updated_likes_emails = false

      ref =
        push_doc(socket, @updated_user_pref_sub_doc,
          variables: %{"user_id" => user.id, "id" => user.preference.id}
        )

      assert_reply ref, :ok, %{subscriptionId: subscription_id}

      ref =
        push_doc(socket, @update_user_pref_doc,
          variables: %{
            "user_id" => user.id,
            "id" => user.preference.id,
            "likes_emails" => updated_likes_emails
          }
        )

      assert_reply ref, :ok, reply

      assert %{
               data: %{
                 "updateUserPreferences" => %{
                   "id" => pref_id,
                   "user_id" => ^user_id,
                   "likes_emails" => ^updated_likes_emails
                 }
               }
             } = reply

      assert_push "subscription:data", data

      assert %{
               subscriptionId: ^subscription_id,
               result: %{
                 data: %{
                   "updatedUserPreferences" => %{
                     "id" => pref_id,
                     "user_id" => ^user_id,
                     "likes_emails" => ^updated_likes_emails
                   }
                 }
               }
             } = data
    end
  end
end
