defmodule CustomerGqlWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ChannelTest

      @endpoint CustomerGqlWeb.Endpoint
    end
  end
end
