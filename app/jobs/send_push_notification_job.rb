class SendPushNotificationJob < ApplicationJob
  queue_as :transmit_push_notifications

  def max_attempts
    3
  end

  def perform(tokens, message)
    tokens.each do |token|
      @notifcation = PushNotification.new(token, message)
      @notifcation.send_push_notification
    end
  end

end
