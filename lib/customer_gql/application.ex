defmodule CustomerGql.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @events [
    :create_user,
    :update_user,
    :get_user,
    :users,
    :update_user_preferences,
    :created_user,
    :updated_user_preferences,
    :user
  ]

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CustomerGqlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CustomerGql.PubSub},
      # Start the Endpoint (http/https)
      CustomerGqlWeb.Endpoint,
      # Start a worker by calling: CustomerGql.Worker.start_link(arg)
      # {CustomerGql.Worker, arg}
      {Absinthe.Subscription, [CustomerGqlWeb.Endpoint]},
      CustomerGql.Repo,
      {CustomerGql.Analytics, @events}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CustomerGql.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CustomerGqlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
