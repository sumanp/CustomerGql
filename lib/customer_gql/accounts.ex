defmodule CustomerGql.Accounts do
  alias CustomerGql.Repo
  alias CustomerGql.Accounts.User
  alias EctoShorts.Actions

  def list_users(params \\ %{}) do
    Actions.all(User, params)
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
end
