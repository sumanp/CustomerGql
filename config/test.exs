import Config

config :customer_gql, CustomerGql.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "customer_gql_repo_test",
  username: "postgres",
  hostname: "localhost"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :customer_gql, CustomerGqlWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Qa0bTFUqRThyOokXmkQSI6Pj5Bqt69xWCa02vtXa4JXvgwlrMnRoui6mNJ8Y2yw",
  server: false

# In test we don't send emails.
config :customer_gql, CustomerGql.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
