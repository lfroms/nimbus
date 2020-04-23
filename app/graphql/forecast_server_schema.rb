# frozen_string_literal: true
class ForecastServerSchema < GraphQL::Schema
  disable_introspection_entry_points if Rails.env.production?

  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections
end
