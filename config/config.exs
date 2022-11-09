# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :customer_gql, CustomerGql.Repo,
  database: "customer_gql_repo",
  username: "postgres",
  hostname: "localhost"

config :customer_gql,
  ecto_repos: [CustomerGql.Repo]

# Configures the endpoint
config :customer_gql, CustomerGqlWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CustomerGqlWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CustomerGql.PubSub,
  live_view: [signing_salt: "joWtGGTG"]

config :ecto_shorts,
  repo: CustomerGql.Repo,
  error_module: EctoShorts.Actions.Error

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :customer_gql, CustomerGql.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
