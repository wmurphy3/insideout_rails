class Api::V1::PeopleController < Api::V1::ApplicationController
  include ApplicationHelper
  before_action :save_spot, only: [:index]

  def index
    @people = User.where({
      gender: preferences(current_user),
      "allow_#{current_user.gender}".to_sym => true,
    }).where.not(id: Match.where(accepter_id: current_user.id).select(:asker_id))
      .where.not(id: Match.where(asker_id: current_user.id).select(:accepter_id))
      .where.not(id: current_user.id)
      .page(@page)

    render json: @people,
      meta:             get_pagination,
      each_serializer:  PersonSerializer,
      longitude:        current_user.longitude,
      latitude:         current_user.latitude,
      user_id:          current_user.id
  end

  def show
    @person = User.find(params[:id])
    render json:  @person,
      serializer: PersonSerializer,
      longitude:  current_user.longitude,
      latitude:   current_user.latitude,
      user_id:    current_user.id
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
      total_pages:  @people.total_pages,
      current_page: @page
    }
  end

end
