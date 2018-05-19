class UsersController < ApplicationController
  before_action :redirect_unless_admin
  before_action :set_user, only: [:edit, :update, :destroy, :activate]

  def index
    @users = User.page(params[:page]).with_deleted
  end

  def edit
  end

  def update
    if @user.update(update_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to users_path
    else
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'User was successfully destroy.'
    redirect_to users_path
  end

  def activate
    @user.restore
    flash[:notice] = 'User was successfully activated.'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.where(id: params[:id]).with_deleted.first
  end

  def update_params
    params.require(:user).permit(:email, :first_name, :last_name, :is_admin)
  end

  def redirect_unless_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end

end
