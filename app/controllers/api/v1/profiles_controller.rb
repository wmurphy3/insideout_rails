class Api::V1::ProfilesController < Api::V1::ApplicationController

  def show
    @profile = User.find(current_user.id)
    render json: @profile, serializer: ProfileSerializer
  end

end
