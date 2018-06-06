class User < ApplicationRecord
  acts_as_paranoid

  reverse_geocoded_by :latitude, :longitude

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_profile
  has_many :matches

  paginates_per 20

  scope :subscribed, ->() { where(subscribed: 1) }
  scope :not_me, ->(id) { where.not(id: id) }
end