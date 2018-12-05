class Message < ApplicationRecord
  belongs_to :user

  def user_id(u_id)
    asker_id == u_id ? accepter_id : asker_id
  end
end
