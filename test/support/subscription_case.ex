defmodule CustomerGql.SubscriptionCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use CustomerGql.ChannelCase

      use Absinthe.Phoenix.SubscriptionTest,
        schema: CustomerGqlWeb.Schema

      setup do
        {:ok, socket} = Phoneix.ChannelTest.connect(CustomerGql.Socket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, %{socket: socket}}
      end
    end
  end
end
