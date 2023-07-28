# Used by "mix format"

export_locals_without_parens = [
  field: 2,
  field: 3,
  field: 4,
  field: 5,
]

[
  import_deps: [:ecto_sql],
  export: [locals_without_parens: export_locals_without_parens],
  locals_without_parens: export_locals_without_parens,
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"]
]
