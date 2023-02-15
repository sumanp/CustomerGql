defmodule CustomerGql.AccountsTest do
  use CustomerGql.DataCase

  alias CustomerGql.Accounts
  alias CustomerGql.Accounts.User

  describe "users" do
    @valid_attrs %{name: "some name", email: "some@email.com", preference: %{likes_emails: true}}
    @update_attrs %{
      name: "some updaye name",
      email: "someupdate@email.com",
      preference: %{likes_emails: true}
    }
    @invalid_attrs %{name: nil, email: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users with preference returns users matching preference" do
      user = user_fixture()
      assert Accounts.list_users(%{preference: %{likes_emails: true}}) == [user]
    end

    test "list_users with after" do
    end

    test "list_users with before" do
    end

    test "list_users with first" do
    end

    test "list_users/0 returns no users" do
    end
  end
end
