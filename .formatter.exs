[
  import_deps: [:phoenix],
  inputs: ["*.{ex,exs}", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    # Absinthe
    arg: :*,
    field: :*,
    resolve: :*,
    middleware: :*,
    trigger: :*,
    config: :*,
    parse: :*,
    serialize: :*,
    value: :*,
    resolve_type: :*,
    import_types: :*,
    import_fields: :*,
    interface: :*,
    union: :*,
  ]
]
