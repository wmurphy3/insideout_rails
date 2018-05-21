class DeclineMatch < ApplicationRecord
  belongs_to :asker,    class_name: "User", foreign_key: "asker_id"
  belongs_to :accepter, class_name: "User", foreign_key: "accepter_id"

  scope :active, ->() { where(accepted: 1) }
  scope :mine, ->(id) { where(asker_id: id).or(accepter_id: id) }
end
