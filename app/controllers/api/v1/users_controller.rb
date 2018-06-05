class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [:create], raise: false

  def show
    @profile = UserProfile.find_by(user_id: current_user.id)
    render json: @profile, serializer: ProfileSerializer
  end

  def create
    @form = User::Form.from_params(user_profile_params)

    User::Create.call(@form, current_user) do
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
    @user_profile = User.find(params[:id])
    @form = User::Form.from_params(user_profile_params)

    User::Update.call(@form, @user_profile, current_user) do
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

  def update_location
  end

  private

  def user_profile_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

end
