class MobileToken < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :token, :scope => :user_id
end
