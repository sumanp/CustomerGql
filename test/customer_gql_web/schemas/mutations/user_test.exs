defmodule CustomerGqlWeb.Schemas.Mutations.UserTest do
  use CustomerGql.DataCase, async: true

  alias CustomerGqlWeb.Schema
  alias CustomerGql.Accounts

  @update_user_doc """
  mutation UpdateUser($id: ID!, $name: String!, $email: String!) {
    updateUser(id: $id, name: $name, email: $email) {
      id
      name
      email
    }
  }
  """

  describe "@updateUser" do
    test "updates a user by id" do
      assert {:ok, user} =
               Accounts.create_user(%{
                 name: "name 1",
                 email: "name1@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      updated_name = "new name"
      updated_email = "new@email.com"

      assert {:ok, %{data: data}} =
               Absinthe.run(@update_user_doc, Schema,
                 variables: %{
                   "id" => user.id,
                   "name" => updated_name,
                   "email" => updated_email
                 }
               )

      updated_user_res = data["updateUser"]

      assert updated_user_res["name"] === updated_name
      assert updated_user_res["email"] === updated_email

      assert {:ok,
              %{
                name: ^updated_name,
                email: ^updated_email
              }} = Accounts.find_user(%{id: user.id})
    end
  end

  @create_user_doc """
  mutation CreateUser($name: String, $email: String, $preference: PreferenceInput) {
    createUser(name: $name, email: $email, preference: $preference) {
      id
      name
      email
      preference {
        likes_emails
        likes_phone_calls
        likes_faxes
      }
    }
  }
  """
  describe "@createUser" do
    test "creates user with params" do
      create_name = "Name"
      create_email = "test@test.com"

      assert {:ok, %{data: data}} =
               Absinthe.run(@create_user_doc, Schema,
                 variables: %{
                   "name" => create_name,
                   "email" => create_email,
                   "preference" => %{"likes_emails" => true}
                 }
               )

      created_user_res = data["createUser"]

      assert created_user_res["name"] === create_name
      assert created_user_res["email"] === create_email

      assert {:ok,
              %{
                name: ^create_name,
                email: ^create_email
              }} = Accounts.find_user(%{id: created_user_res["id"]})
    end
  end
end
