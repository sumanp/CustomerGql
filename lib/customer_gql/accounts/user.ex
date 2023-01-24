defmodule CustomerGql.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias CustomerGql.Repo

  schema "users" do
    field :email, :string
    field :name, :string

    has_one :preference, CustomerGql.Accounts.Preference
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

  def filter_where(params) do
    Enum.reduce(params, dynamic(true), fn
      {field_name, value}, dynamic ->
        dynamic([preference: p], ^dynamic and field(p, ^field_name) == ^value)
    end)
  end
end
