class Api::V1::MobileTokensController < Api::V1::ApplicationController

  def create
    @form = MobileToken::Form.from_params(create_params)
    MobileToken::Create.call(@form, current_user) do
      on(:ok) do |mobile_token|
        render({
          :json       => mobile_token,
          :status     => :created,
        })
      end
      on(:invalid) do |errors|
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def create_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
