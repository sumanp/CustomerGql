defmodule CustomerGql.SubscriptionCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use CustomerGqlWeb.ChannelCase

      use Absinthe.Phoenix.SubscriptionTest,
        schema: CustomerGqlWeb.Schema

      setup do
        {:ok, socket} = Phoenix.ChannelTest.connect(CustomerGqlWeb.UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, %{socket: socket}}
      end
    end
  end
end
