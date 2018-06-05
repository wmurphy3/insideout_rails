class Api::V1::ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Doorkeeper code
  before_action :doorkeeper_authorize!
  respond_to :json

  protected

  # Devise methods
  # Authentication key(:username) and password field will be added automatically by devise.
  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :name, :description, :age, :gender,
    :favorite_movie, :favorite_food, :favorite_song, :job_title, :hobbies, :school, :social_media_link,
    :snap_chat_name, :allow_male, :allow_female, :allow_other]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  # Doorkeeper methods
  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
