# TODO: END MATCH

class Api::V1::MatchesController < Api::V1::ApplicationController
  before_action :set_match, only: [:show, :update]

  def index
    @matches = Match.active.mine(current_user.id)

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

  def create_decline
    @form = DeclineMatch::Form.from_params(match_params)

    DeclineMatch::Create.call(@form, current_user) do
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

  private

  def match_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

  def set_match
    @match = Match.find(params[:id])
  end

end
