class MobileToken::Create < Rectify::Command
  def initialize(form, user)
    @form = form
    @user = user
  end

  def call
    return broadcast(:invalid, form) if form.invalid?

    transaction do
      transform_params
      create_mobile_token
    end

    broadcast(:ok, device)
  end

  private

  attr_reader :form, :user, :device

  def transform_params
    @transformed_params = {
      :device_type  => form.platform,
      :user_id      => user.id
    }
  end

  def create_mobile_token
    @device = MobileToken.where(token: form.token).first_or_create
    @device = @device.update!(@transformed_params)
  end
end
