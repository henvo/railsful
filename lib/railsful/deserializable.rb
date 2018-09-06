# frozen_string_literal: true

module Railsful
  module Deserializable
    extend ActiveSupport::Concern

    included do
      def deserialized_params
        Deserializer.new(params.to_unsafe_hash).deserialize
      end
    end
  end
end
