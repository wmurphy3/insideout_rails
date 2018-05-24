class Api::V1::MessagesController < Api::V1::ApplicationController
  def show
    @messages = Message.where(match_id: params[:id]).order("created_at DESC")
    render json: @messages, each_serializer: MessageSerializer
  end

  def create
    Message::Create.call(message_params, current_user) do
      on(:ok) do |message|
        render({
          :json       => message,
          :status     => :created,
          :serializer => MessageSerializer
        })
      end
      on(:invalid) do |errors|
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def message_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
