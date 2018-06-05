class Api::V1::PeopleController < Api::V1::ApplicationController
  # TODO move to a job
  before_action :save_spot

  def show
    # TODO figure out a better algo
    @people = User.subscribed
                  .where.not(id: Match.mine(current_user.id).pluck(:accepter_id, :asker_id))
                  .not_me(current_user.id)
                  .near([params[:latitude], params[:longitude]], 99999)
    @people = @people.where(gender: 'male', "allow_#{current_user.gender}".to_sym => true) if current_user.allow_male?
    @people = @people.where(gender: 'female', "allow_#{current_user.gender}".to_sym => true) if current_user.allow_female?
    @people = @people.where(gender: 'other', "allow_#{current_user.gender}".to_sym => true) if current_user.allow_other?

    render json: @people, each_serializer: PersonSerializer, longitude: current_user.longitude, latitude: current_user.latitude
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
