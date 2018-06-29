class UsersController < ApplicationController
  before_action :redirect_unless_admin
  before_action :set_user, only: [:destroy]

  def index
    @users = ReportedUser.page(params[:page]).with_deleted
  end

  def destroy
    @user.destroy
    flash[:notice] = 'User was successfully destroy.'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def redirect_unless_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end

end
