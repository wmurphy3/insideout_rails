class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [:create, :send_recovery_email], raise: false

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

  def save_image
    @user = User.find(current_user.id)
    Thread.current[:current_user] = @user

    @user.image = params[:image]

    if @user.save
      render({
        :json       => @user,
        :status     => :created,
        :serializer => ProfileSerializer
      })
    else
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end
  end

  def send_recovery_email
    @user = User.find_by_email(params[:email].downcase)

    if @user.present?
      if @user.send_reset_password_instructions
        render json: { message: 'Recovery email sent' }, status: 200
      else
        render json: { errors: 'Could not send email' }, status: 422
      end
    else
      render json: { errors: 'Could not send email' }, status: 422
    end
  end

  private

  def user_profile_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

end
