# frozen_string_literal: true

module Railsful
  module Interceptors
    # This interceptor checks the given json object for an 'errors' array
    # and checks if any errors are available.
    module Errors
      def render(options)
        super(errors_options(options))
      end

      def errors_options(options)
        return options unless errors?(options)

        options.merge(json: { errors: errors(options) })
      end

      def errors?(options)
        !errors(options).empty?
      end

      # :reek:ManualDispatch
      # :reek:UtilityFunction
      def errors(options)
        # As always get the object that should be rendered
        renderable = options[:json]

        # Return if renderable does not have an errors array.
        return [] unless renderable.respond_to? :errors

        # Return the erors
        renderable.errors
      end
    end
  end
end
