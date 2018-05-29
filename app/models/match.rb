class Match < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :asker,    class_name: "User", foreign_key: "asker_id"
  belongs_to :accepter, class_name: "User", foreign_key: "accepter_id"

  scope :mine, ->(id) { where(asker_id: id).or(Match.where(accepter_id: id)) }
end
