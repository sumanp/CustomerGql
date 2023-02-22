defmodule CustomerGqlWeb.Resolvers.Analytics do
  alias CustomerGql.Accounts

  def find(%{key: key}, _) do
    event = String.to_existing_atom(key)
    counter = CustomerGql.Analytics.get_event_counter(event)

    {:ok, %{key: event, count: counter}}
  end
end
