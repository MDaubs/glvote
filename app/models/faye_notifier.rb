class FayeNotifier
  def self.publish(channel, params)
    require 'net/http'
    message = { channel: channel, data: params }
    uri = URI.parse(Rails.configuration.faye_url)
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end
