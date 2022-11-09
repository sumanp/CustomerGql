defmodule CustomerGql.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias CustomerGql.Repo

  schema "users" do
    field(:email, :string)
    field(:name, :string)

    has_one(:preference, CustomerGql.Accounts.Preference)
  end

  @available_params [:name, :email]

  @doc false
  def changeset(user, attrs) do
    user
    |> Repo.preload(:preference)
    |> cast(attrs, @available_params)
    |> validate_required(@available_params)
    |> cast_assoc(:preference)
  end
end
