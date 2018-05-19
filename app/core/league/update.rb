class League::Update < Rectify::Command

  def initialize(form, league, user)
    @form = form
    @league = league
    @user = user
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      transform_params
      create_league
      update_users
      remove_old_users
    end

    broadcast(:ok, league)
  end

  private

  attr_reader :form, :user, :league

  def transform_params
    @transformed_params = {
      name:         form.name,
      league_type:  form.type,
      points:       form.points,
      time:         form.time
    }
  end

  def create_league
    League.update(@transformed_params)
  end

  def update_users
    # TODO: Send out push notifications
    form.users.each do |email|
      return if email == user.email

      new_user = User.find_by(email: email)
      league_user = LeagueUser.where(user_id: new_user.id, league_id: league.id).first

      if new_user.present? && !league_user.present?
        LeagueUser.create({
          league_id:  league.id,
          user_id:    new_user.id,
          active:     0
        })
      end
    end
  end

  def remove_old_users
    user_ids = User.where(email: form.users).pluck(:id)
    user_ids << user.id

    league_users = LeagueUser.where
                             .not(user_id: user_ids)
                             .where(league_id: league.id)
                             .update_all(active: 2)
  end
end
