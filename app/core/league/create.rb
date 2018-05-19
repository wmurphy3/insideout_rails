class League::Create < Rectify::Command

  def initialize(form, user)
    @form = form
    @user = user
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      transform_params
      create_league
      add_admin_to_league
      invite_users
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
      time:         form.time,
      admin_id:     user.id
    }
  end

  def create_league
    @league = League.create!(@transformed_params)
  end

  def add_admin_to_league
    LeagueUser.create({
      league_id:  league.id,
      user_id:    user.id,
      points:     0,
      active:     1
    })
  end

  def invite_users
    # TODO: Send out push notifications
    form.users.each do |email|
      return if email == user.email

      new_user = User.find_by(email: email)

      if new_user.present?
        LeagueUser.create({
          league_id:  league.id,
          user_id:    new_user.id,
          points:     0,
          active:     0
        })
      end
    end
  end
end
