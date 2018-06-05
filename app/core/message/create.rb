class Message::Create < Rectify::Command

  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    transaction do
      find_or_create_match
      transform_params
      create_message
    end

    broadcast(:ok, message)
  rescue ActiveRecord::RecordInvalid => e
    broadcast(:invalid, e.messages)
  end

  private

  attr_reader :params, :user, :message, :match

  def find_or_create_match
    unless params[:match_id]
      @match = Match.create(asker_id: user.id, accepter_id: params[:user_id])
    end
  end

  def transform_params
    @transformed_params = {
      user_id:       user.id,
      match_id:      (params[:match_id] || match.id),
      message:       params[:message]
    }
  end

  def create_message
    @message = Message.new(@transformed_params)
    @message.save
  end
end
