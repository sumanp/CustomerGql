defmodule CustomerGql.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias EctoShorts.CommonChanges
  alias CustomerGql.Accounts.User
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
    |> cast(attrs, @available_params)
    |> validate_required(@available_params)
    |> CommonChanges.preload_change_assoc(:preference)
  end

  def filter_by_preference(pref_params) do
    User
    |> join(:inner, [u], assoc(u, :preference), as: :preference)
    |> preload([preference: p], preference: p)
    |> where(^filter_where(pref_params))
  end

  def filter_where(pref_params) do
    Enum.reduce(pref_params, dynamic(true), fn
      {field_name, value}, dynamic ->
        dynamic([preference: p], ^dynamic and field(p, ^field_name) == ^value)
    end)
  end
end
