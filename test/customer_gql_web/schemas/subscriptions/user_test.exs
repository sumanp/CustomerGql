defmodule CustomerGqlWeb.Subscriptions.UserTest do
  use CustomerGql.SubscriptionCase
  import Ecto.Query

  alias CustomerGql.Accounts.User
  alias CustomerGql.Repo

  @create_user_doc """
  mutation CreateUser($name: String, $email: String, $preference: PreferenceInput) {
    createUser(name: $name, email: $email, preference: $preference) {
      id
      name
      email
    }
  }
  """

  @created_user_sub_doc """
  subscription CreatedUser {
    createdUser {
      id
      name
      email
    }
  }
  """

  describe "@userCreated" do
    test "sends a user when @updateUser mutation is triggered", %{socket: socket} do
      create_name = "Name"
      create_email = "test@test.com"

      ref = push_doc(socket, @created_user_sub_doc)

      assert_reply ref, :ok, %{subscriptionId: subscription_id}

      ref =
        push_doc(socket, @create_user_doc,
          variables: %{
            "name" => create_name,
            "email" => create_email,
            "preference" => %{"likes_emails" => true}
          }
        )

      assert_reply ref, :ok, reply
      user = User |> last |> Repo.one()
      user_id = to_string(user.id)

      assert %{
               data: %{
                 "createUser" => %{
                   "id" => ^user_id,
                   "name" => ^create_name,
                   "email" => ^create_email
                 }
               }
             } = reply

      assert_push "subscription:data", data

      assert %{
               subscriptionId: ^subscription_id,
               result: %{
                 data: %{
                   "createdUser" => %{
                     "id" => ^user_id,
                     "name" => ^create_name,
                     "email" => ^create_email
                   }
                 }
               }
             } = data
    end
  end
end
