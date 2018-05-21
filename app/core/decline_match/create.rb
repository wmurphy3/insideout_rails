class DeclineMatch::Create < Rectify::Command

  def initialize(form, user)
    @form = form
    @user = user
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      transform_params
      create_match
    end

    broadcast(:ok, match)
  end

  private

  attr_reader :form, :user, :match

  def transform_params
    @transformed_params = {
      asker_id:              user.id,
      accepter_id:           form.accepter_id,
    }
  end

  def create_match
    @match = DeclineMatch.new(@transformed_params)
    @match.save
  end
end
