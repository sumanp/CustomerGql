defmodule CustomerGqlWeb.Schemas.Queries.UserTest do
  use CustomerGql.DataCase, async: true

  alias CustomerGqlWeb.Schema
  alias CustomerGql.Accounts

  @all_user_doc """
  query AllUser($first: Int, $after: Int, $before: Int, $preference: PreferenceInput) {
    users(first: $first, after: $after, before: $before, preference: $preference) {
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

  describe "@users" do
    test "fetch first x users" do
      assert {:ok, user_1} =
               Accounts.create_user(%{
                 name: "name 1",
                 email: "name1@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, user_2} =
               Accounts.create_user(%{
                 name: "name 2",
                 email: "name2@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, _} =
               Accounts.create_user(%{
                 name: "name 3",
                 email: "name3@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, %{data: data}} =
               Absinthe.run(@all_user_doc, Schema,
                 variables: %{
                   "first" => 2
                 }
               )

      assert length(data["users"]) === 2
      assert List.first(data["users"])["id"] === to_string(user_1.id)
      assert List.last(data["users"])["id"] === to_string(user_2.id)
    end

    test "fetch users after x" do
      assert {:ok, user_1} =
               Accounts.create_user(%{
                 name: "name 1",
                 email: "name1@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, user_2} =
               Accounts.create_user(%{
                 name: "name 2",
                 email: "name2@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, user_3} =
               Accounts.create_user(%{
                 name: "name 3",
                 email: "name3@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, %{data: data}} =
               Absinthe.run(@all_user_doc, Schema,
                 variables: %{
                   "after" => user_1.id
                 }
               )

      assert length(data["users"]) === 2
      assert List.first(data["users"])["id"] === to_string(user_2.id)
      assert List.last(data["users"])["id"] === to_string(user_3.id)
    end

    test "fetch users before x" do
      assert {:ok, user_1} =
               Accounts.create_user(%{
                 name: "name 1",
                 email: "name1@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, user_2} =
               Accounts.create_user(%{
                 name: "name 2",
                 email: "name2@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, user_3} =
               Accounts.create_user(%{
                 name: "name 3",
                 email: "name3@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, %{data: data}} =
               Absinthe.run(@all_user_doc, Schema,
                 variables: %{
                   "before" => user_3.id
                 }
               )

      assert length(data["users"]) === 2
      assert List.first(data["users"])["id"] === to_string(user_1.id)
      assert List.last(data["users"])["id"] === to_string(user_2.id)
    end

    test "fetch users by matching preference" do
      assert {:ok, user_1} =
               Accounts.create_user(%{
                 name: "name 1",
                 email: "name1@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, user_2} =
               Accounts.create_user(%{
                 name: "name 2",
                 email: "name2@email.com",
                 preference: %{
                   likes_emails: true,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, user_3} =
               Accounts.create_user(%{
                 name: "name 3",
                 email: "name3@email.com",
                 preference: %{
                   likes_emails: false,
                   likes_phonecalls: true,
                   likes_faxes: true
                 }
               })

      assert {:ok, %{data: data}} =
               Absinthe.run(@all_user_doc, Schema,
                 variables: %{
                   "preference" => %{"LikesEmails" => true}
                 }
               )

      assert length(data["users"]) === 2
      assert List.first(data["users"])["id"] === to_string(user_1.id)
      assert List.last(data["users"])["id"] === to_string(user_2.id)
    end
  end

  @get_user_by_id_doc """
  query GetUserByID($id: ID!) {
    user(id: $id,) {
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
  describe "@user" do
    test "fetch user with matching id" do
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

      assert {:ok, %{data: data}} =
               Absinthe.run(@get_user_by_id_doc, Schema,
                 variables: %{
                   "id" => user.id
                 }
               )

      assert data["user"]["id"] === to_string(user.id)
    end
  end
end
