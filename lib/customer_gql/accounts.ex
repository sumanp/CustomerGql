defmodule CustomerGql.Accounts do
  alias CustomerGql.Repo
  alias CustomerGql.Accounts.User
  alias CustomerGql.Accounts.Preference
  alias EctoShorts.Actions

  def list_users(params \\ %{}) do
    pref_filter = Map.get(params, :preferences, %{})
    pref_keys = Map.keys(pref_filter)

    users = Actions.all(User, Map.put(params, :preload, [:preference]))

    Enum.reduce(users, [], fn %{preference: preference} = user, acc ->
      user_preference =
        preference
        |> Map.from_struct()
        |> Map.take(pref_keys)

      if Map.equal?(pref_filter, user_preference) do
        [user | acc]
      else
        acc
      end
    end)
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
