defmodule CustomerGql.Middlewares.Analytics do
  @behaviour Absinthe.Middleware

  def call(resolution, _opts) do
    event =
      resolution.definition.name
      |> Macro.underscore()
      |> String.to_existing_atom()

    unless event === :resolver_hits do
      CustomerGql.Analytics.register_hit(event)
    end

    resolution
  end
end
