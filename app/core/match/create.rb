class Match::Create < Rectify::Command

  def initialize(form, user)
    @form = form
    puts "@form: #{form.inspect}"
    @user = user
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      find_match

      if match.present?
        update_match
      else
        transform_params
        create_match
      end
    end

    broadcast(:ok, match)
  end

  private

  attr_reader :form, :user, :match

  def find_match
    @match = Match.where(asker_id: form.accepter_id, accepter_id: user.id).first
  end

  def update_match
    match.accepted = true
    match.save
  end

  def transform_params
    @transformed_params = {
      asker_id:              user.id,
      accepter_id:           form.accepter_id,
    }
  end

  def create_match
    @match = Match.new(@transformed_params)
    @match.save
  end
end
