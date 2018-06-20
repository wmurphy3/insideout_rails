class MobileToken::Form < Rectify::Form
  attribute :platform,  String
  attribute :token,     String

  validates :platform, :token, :presence => true
end
