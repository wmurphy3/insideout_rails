require "image_uploader"

class User < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  acts_as_paranoid
  reverse_geocoded_by :latitude, :longitude
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_profile
  has_many :matches
  has_many :mobile_tokens

  paginates_per 20

  scope :subscribed, ->() { where(subscribed: 1) }
  scope :not_me, ->(id) { where.not(id: id) }
end
