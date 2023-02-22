defmodule CustomerGqlWeb.Schemas.Queries.AnalyticsTest do
  use CustomerGql.DataCase, async: true

  alias CustomerGqlWeb.Schema

  @resolver_hits_doc """
  query ResolverHits($key: String!) {
    resolverHits(key: $key) {
      key
      count
    }
  }
  """

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

  setup do
    events = [
      :create_user,
      :update_user,
      :get_user,
      :users,
      :update_user_preferences,
      :created_user,
      :updated_user_preferences,
      :user
    ]

    {:ok, pid} = CustomerGql.Analytics.start_link(events, name: nil)
    %{pid: pid}
  end

  describe "@hits" do
    test "hit count is 0 for unrequested endpoint" do
      assert {:ok, %{data: data}} =
               Absinthe.run(@resolver_hits_doc, Schema,
                 variables: %{
                   "key" => "update_user"
                 }
               )

      assert data["resolverHits"]["key"] === "update_user"
      assert data["resolverHits"]["count"] === 0
    end

    test "returns appropriate hit count of requested key" do
      create_name = "Name"
      create_email = "test@test.com"

      assert {:ok, %{data: _data}} =
               Absinthe.run(@create_user_doc, Schema,
                 variables: %{
                   "name" => create_name,
                   "email" => create_email,
                   "preference" => %{"likes_emails" => true}
                 }
               )

      assert {:ok, %{data: data}} =
               Absinthe.run(@resolver_hits_doc, Schema,
                 variables: %{
                   "key" => "create_user"
                 }
               )

      assert data["resolverHits"]["key"] === "create_user"
      assert data["resolverHits"]["count"] === 1

      assert {:ok, %{data: _data}} =
               Absinthe.run(@create_user_doc, Schema,
                 variables: %{
                   "name" => create_name,
                   "email" => create_email,
                   "preference" => %{"likes_emails" => true}
                 }
               )

      assert {:ok, %{data: data}} =
               Absinthe.run(@resolver_hits_doc, Schema,
                 variables: %{
                   "key" => "create_user"
                 }
               )

      assert data["resolverHits"]["key"] === "create_user"
      assert data["resolverHits"]["count"] === 2
    end
  end
end
