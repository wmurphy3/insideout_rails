class Message::Create < Rectify::Command

  def initialize(params, user)
    puts "params: #{params}"
    @params = params
    @user = user
  end

  def call
    transaction do
      transform_params
      create_message
    end

    broadcast(:ok, message)
  end

  private

  attr_reader :params, :user, :message

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
end
