# frozen_string_literal: true

module Railsful
  module Serializable
    def render(options = nil, extra_options = {}, &block)
      super(fast_jsonapi_options(options), extra_options, &block)
    end

    def fast_jsonapi_options(options)
      Serializer.new(self).render(options)
    end
  end
end
