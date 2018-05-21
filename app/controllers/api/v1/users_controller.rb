class Api::V1::UsersController < Api::V1::ApplicationController

  def show
    @profile = UserProfile.find_by(user_id: current_user.id)
    render json: @profile, serializer: ProfileSerializer
  end

  def create
    @form = UserProfile::Form.from_params(user_profile_params)

    UserProfile::Create.call(@form, current_user) do
      on(:ok) do |user_profile|
        render({
          :json       => user_profile,
          :status     => :created,
          :serializer => ProfileSerializer
        })
      end
      on(:invalid) do |errors|
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end

  def update
    @user_profile = UserProfile.find(params[:id])
    @form = UserProfile::Form.from_params(user_profile_params)

    UserProfile::Update.call(@form, @user_profile, current_user) do
      on(:ok) do |user_profile|
        render({
          :json       => user_profile,
          :status     => :created,
          :serializer => ProfileSerializer
        })
      end
      on(:invalid) do |errors|
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def user_profile_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

end
