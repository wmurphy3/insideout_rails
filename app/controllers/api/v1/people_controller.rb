class Api::V1::PeopleController < Api::V1::ApplicationController
  before_action :save_spot, only: [:index]

  def index
    @people = User.subscribed
                  .where.not(id: Match.mine(current_user.id).pluck(:accepter_id, :asker_id))
                  .not_me(current_user.id)
                  .near([current_user.latitude, current_user.longitude], 99999)
    @people = @people.where(gender: 'male', "allow_#{current_user.gender}".to_sym => true) if current_user.allow_male?
    @people = @people.where(gender: 'female', "allow_#{current_user.gender}".to_sym => true) if current_user.allow_female?
    @people = @people.where(gender: 'other', "allow_#{current_user.gender}".to_sym => true) if current_user.allow_other?
    @people = @people.page(@page)

    render json: @people,
      meta: get_pagination,
      each_serializer: PersonSerializer,
      longitude: current_user.longitude,
      latitude: current_user.latitude,
      user_id: current_user.id
  end

  def show
    @person = User.find(params[:id])
    render json: @person,
      serializer: PersonSerializer,
      longitude: current_user.longitude,
      latitude: current_user.latitude,
      user_id: current_user.id
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

  def get_pagination
    {
      total_pages: @people.total_pages,
      current_page: @page
    }
  end

end
