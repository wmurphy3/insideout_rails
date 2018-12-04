class Match < ApplicationRecord
  acts_as_paranoid

  belongs_to :asker,    class_name: "User", foreign_key: "asker_id"
  belongs_to :accepter, class_name: "User", foreign_key: "accepter_id"

  scope :mine, ->(id) { where(asker_id: id).or(Match.where(accepter_id: id)) }

  def both_accepted?
    asker_next_step && accepter_next_step
  end

  def set_user(user)
    self.accepter_next_step = true if self.accepter_id == user.id
    self.asker_next_step = true if self.asker_id == user.id
  end

  def send_next_step_accepted
    tokens = self.asker.mobile_tokens.pluck(:token) || []
    tokens << self.accepter.mobile_tokens.pluck(:token)

    SendPushNotificationJob.perform_later(tokens, "You can now view #{user.name}'s profile picture")
  end

  def isnt_me(user)
    self.accepter_id == user.id ? self.asker : self.accepter
  end

  def self.matched(user_id, my_id)
    match = Match.where(accepter_id: user_id, asker_id: my_id).or(Match.where(accepter_id: my_id, asker_id: user_id)).first
    return false unless match

    match.created_at < 1.day.ago
  end

end
