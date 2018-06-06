# TODO: END MATCH

class Api::V1::MatchesController < Api::V1::ApplicationController
  before_action :set_match, only: [:show, :update, :destroy, :next_step]

  def index
    @matches = Match.mine(current_user.id)
    render json: @matches, each_serializer: MatchSerializer, user_id: current_user.id
  end

  def show
    render json: @match, serializer: MatchSerializer, user_id: current_user.id
  end

  def create
    @form = Match::Form.from_params(match_params)

    Match::Create.call(@form, current_user) do
      on(:ok) do |match|
        render({
          :json       => {message:'matched'},
          :status     => :created,
        })
      end
      on(:invalid) do |errors|
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end

  def next_step
    @match.accepter_next_step = true if @match.accepter_id == current_user.id
    @match.asker_next_step = true if @match.asker_id == current_user.id

    if @match.save
      render({ :json => {message:'matched'}, :status => :created })
    else
      render json: { errors: @match.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    Match::Update.call(@match, current_user) do
      on(:ok) do |match|
        render({
          :json       => match,
          :status     => :created,
          :serializer => MatchSerializer
        })
      end
      on(:invalid) do |errors|
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @match.destroy
      render json: '', status: :no_content
    else
      render json: { errors: @match.errors }, status: :unprocessable_entity
    end
  end

  private

  def match_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

  def set_match
    @match = Match.find(params[:id])
  end

end
