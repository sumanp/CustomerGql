defmodule CustomerGqlWeb.Types.Analytics do
  use Absinthe.Schema.Notation

  @desc "Resolver hits"
  object :hits do
    field :key, :string
    field :count, :integer
  end
end
