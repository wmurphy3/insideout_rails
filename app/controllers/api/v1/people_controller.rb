class Api::V1::PeopleController < Api::V1::ApplicationController

  def show
    @people = User.subscribed.not_me(current_user.id)

    render json: @people, each_serializer: PersonSerializer
  end

end
