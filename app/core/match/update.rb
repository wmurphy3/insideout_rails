class Match::Update < Rectify::Command

  def initialize(match, user)
    @match = match
    @user = user
  end

  def call
    transaction do
      update_match
    end

    broadcast(:ok, match)
  end

  private

  attr_reader :user, :match

  def update_match
    if match.asker_id == user.id
      match.asker_next_step = true
    else
      match.accepter_next_step = true
    end

    match.save
  end

end
