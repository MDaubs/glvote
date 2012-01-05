require 'spec_helper'

describe FayeNotifier do
  describe ".publish" do
    it "publishes a Faye message" do
      Rails.configuration.stub(:faye_url).and_return('url')
      message = { channel: '/channel', data: 'arguments' }
      uri = URI.parse('url')
      require 'net/http'
      Net::HTTP.should_receive(:post_form).with(uri, message: message.to_json)
      FayeNotifier.publish '/channel', 'arguments'
    end
  end
end
