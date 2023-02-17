defmodule CustomerGqlWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ChannelTest

      @endpoint CustomerGqlWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(CustomerGql.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(CustomerGql.Repo, {:shared, self()})
    end

    :ok
  end
end
