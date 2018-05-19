class League::Form < Rectify::Form
  mimic :league

  attribute :name, String
  attribute :type, String
  attribute :points, Integer
  attribute :time, DateTime
  attribute :users, Array

  validates :name, :type, :presence => true
end
