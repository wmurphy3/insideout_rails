class Api::V1::PeopleController < Api::V1::ApplicationController
  # TODO move to a job
  before_action :save_spot

  def show
    @people = User.subscribed.not_me(current_user.id).near([params[:latitude], params[:longitude]], 99999)
    render json: @people, each_serializer: PersonSerializer
  end

  private

  def save_spot
    if params[:longitude] && params[:latitude]
      @user = User.find(current_user.id)
      @user.latitude = params[:latitude].to_f
      @user.longitude = params[:longitude].to_f
      @user.save
    end
  end

end
