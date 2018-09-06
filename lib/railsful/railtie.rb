# frozen_string_literal: true

module Railsful
  class Railtie < Rails::Railtie
    initializer 'railsful.action_controller' do
      ActiveSupport.on_load(:action_controller) do
        puts "Prepending #{self} with Railsful::Serializable"
        prepend Railsful::Serializable

        puts "Including #{self} in Railsful::Deserializable"
        include Railsful::Deserializable
      end
    end
  end
end
