defmodule CustomerGqlWeb.User do
  @users [
    %{
      id: 1,
      name: "Bill",
      email: "bill@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: true,
        likes_faxes: true
      }
    },
    %{
      id: 2,
      name: "Alice",
      email: "alice@gmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: false,
        likes_faxes: true
      }
    },
    %{
      id: 3,
      name: "Jill",
      email: "jill@hotmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: true,
        likes_faxes: false
      }
    },
    %{
      id: 4,
      name: "Tim",
      email: "tim@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: false,
        likes_faxes: false
      }
    }
  ]


  def all(params) do
    case filter_by(params) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp filter_by(params) do
    pref_keys = Map.keys(params)
    Enum.reduce(@users, [], fn(%{preferences: preferences} = user, acc) ->
      if Map.equal?(params, Map.take(preferences, pref_keys)) do
        [user | acc]
      else
        acc
      end
    end)
  end

  def find(%{id: id}) do
    case Enum.find(@users, &(&1.id === id)) do
      nil -> {:error, %{message: "not found", details: %{id: id}}}
      user -> {:ok, user}
    end
  end

  def update(id, params) do
    with {:ok, user} <- find(%{id: id}) do
      {:ok, Map.merge(user, params)}
    end
  end

  def create(params) do
    {:ok, params}
  end

  def update_preferences(user_id, params) do
    with {:ok, user} <- find(%{id: user_id}) do
      {:ok, Map.merge(user[:preferences], params)}
    end
  end
end
