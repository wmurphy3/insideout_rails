class Users::PasswordsController < Devise::PasswordsController
  before_action :set_params, only: [:update, :edit]
  respond_to :json
  layout 'empty'

  # # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end
  #
  # # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash[:success] = 'Updated password'
      render :edit
    else
      flash[:error] = resource.errors.full_messages
      render :edit
    end
  end

  private
  def set_params
    @redirect_uri = params[:redirect_uri]
  end
end
