class User::Form < Rectify::Form
  mimic :user

  attribute :email,                 String
  attribute :name,                  String
  attribute :password,              String
  attribute :password_confirmation, String
  attribute :description,           String
  attribute :interests,             Object
  attribute :job_title,             String
  attribute :school,                String
  attribute :image_data,            Object
  attribute :gender,                String
  attribute :age,                   Integer
  attribute :distance,              Integer
  attribute :allow_male,            Boolean
  attribute :allow_female,          Boolean
  attribute :allow_other,           Boolean
  attribute :address_zip,           String

  validates :description, :email, :name, :password, :password_confirmation,
    :age, :gender, :presence => true
  validate :validate_email

  def validate_email
    return if User.where(email: email).count == 0

    errors.add(:email, 'is already in use')
  end
end
