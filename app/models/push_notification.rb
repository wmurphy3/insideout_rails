require 'exponent-server-sdk'

class PushNotification
  def initialize(token, message)
    @message = message
    @token = token

    @exponent = ::Exponent::Push::Client.new
  end

  def send_push_notification
    messages = [{
      to: @token,
      sound: "default",
      body: @message
    }]

    @exponent.publish messages
  end

end
