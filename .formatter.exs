# Used by "mix format"

export_locals_without_parens = [
  field: 2,
  field: 3,
  field: 4,
  field: 5,
  has_one: 2,
  has_one: 3,
  has_one: 4,
  has_one: 5,
  belongs_to: 2,
  belongs_to: 3,
  belongs_to: 4,
  belongs_to: 5,
  has_many: 2,
  has_many: 3,
  has_many: 4,
  has_many: 5,
  many_to_many: 2,
  many_to_many: 3,
  many_to_many: 4,
  many_to_many: 5,
  plug: 1,
  plug: 2,
  plug: 3
]

[
  import_deps: [:ecto_sql],
  export: [locals_without_parens: export_locals_without_parens],
  locals_without_parens: export_locals_without_parens,
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"]
]
