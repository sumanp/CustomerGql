defmodule CustomerGql.Accounts do
  alias CustomerGql.Accounts.User
  alias CustomerGql.Accounts.Preference
  alias EctoShorts.Actions
  import Ecto.Query

  def list_users(params \\ %{}) do
    query =
      User
      |> join(:inner, [u], assoc(u, :preference), as: :preference)
      |> where(^User.filter_where(Map.get(params, :preferences, %{})))

    Actions.all(query, Map.put(params, :preload, [:preference]))
  end

  def find_user(params) do
    Actions.find(User, params)
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def create_user(params) do
    Actions.create(User, params)
  end

  def update_preference(id, params) do
    Actions.update(Preference, id, params)
  end
end
