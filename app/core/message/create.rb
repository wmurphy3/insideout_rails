class Message::Create < Rectify::Command

  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    transaction do
      find_match
      find_receiver
      transform_params
      create_message
      send_push_notification
      send_pusher
    end

    broadcast(:ok, message)
  rescue ActiveRecord::RecordInvalid => e
    broadcast(:invalid, e.messages)
  end

  private

  attr_reader :params, :user, :message, :match, :token, :user_id

  def find_match
    @match = Match.find(params[:match_id])
  end

  def find_receiver
    @token = MobileToken.where(user_id: match.user_id(user.id)).pluck(:token)
  end

  def transform_params
    @transformed_params = {
      user_id:       user.id,
      match_id:      params[:match_id],
      message:       params[:message]
    }
  end

  def create_message
    @message = Message.new(@transformed_params)
    @message.save
  end

  def send_push_notification
    SendPushNotificationJob.perform_later(token, "A message from #{user.name} is waiting for you") unless token.empty?
  end

  def send_pusher
    Pusher.trigger((params[:match_id] || match.id), 'message', {
      id:       message.id,
      user_id:  user.id,
      message:  message.message,
      match_id: message.match_id
    })
  end
end
