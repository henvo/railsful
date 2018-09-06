# frozen_string_literal: true

module Railsful
  module Interceptors
    # This interceptors implements the "include" functionality for
    # a given record or a relation.
    module Include
      def render(options)
        super(include_options(options))
      end

      def include_options(options)
        # Only GET requests should have the "include" functionality,
        # since it may be a parameter in a create or update action.
        return options unless method == 'GET'

        # Includes can be given via comma separated query parameters.
        # Example: profile?include=address,settings
        includes = params.fetch(:include, '').split(',')

        # Deep merge include options, so we do not override existing
        # include options.
        options.deeper_merge(include: includes)
      end
    end
  end
end
