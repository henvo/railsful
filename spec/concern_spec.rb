# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe TestController do
  let(:controller) { described_class.new }

  it 'responds to #deserialized_params' do
    expect(controller).to respond_to(:deserialized_params)
  end

  describe '#render' do
    it 'calls the Serializer' do
      expect(Railsful::Serializer)
        .to receive(:new)
        .and_return(double(:foo, render: true))

      controller.render
    end
  end
end
