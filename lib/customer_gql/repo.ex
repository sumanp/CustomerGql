defmodule CustomerGql.Repo do
  use Ecto.Repo,
    otp_app: :customer_gql,
    adapter: Ecto.Adapters.Postgres
end
