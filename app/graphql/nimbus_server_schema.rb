# frozen_string_literal: true
class NimbusServerSchema < GraphQL::Schema
  disable_introspection_entry_points if Rails.env.production?

  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Also use the new error handling:
  use GraphQL::Execution::Errors

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  rescue_from(Weather::Errors::NoDataError) do |_err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError, 'None of the nearby weather stations are able to process the request.'
  end

  rescue_from(Weather::Errors::NoSitesError) do |_err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError, 'There are no weather stations within 500 kilometers of this location.'
  end

  rescue_from(Weather::Errors::UnsupportedLocationError) do |_err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError, 'Weather information for this location is not yet available.'
  end
end
