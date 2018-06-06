class User::Form < Rectify::Form
  mimic :user

  attribute :email,               String
  attribute :name,                String
  attribute :password,              String
  attribute :password_confirmation, String
  attribute :description,         String
  attribute :favorite_food,       String
  attribute :favorite_song,       Integer
  attribute :favorite_movie,      DateTime
  attribute :job_title,           String
  attribute :best_accomplishment, String
  attribute :hobbies,             String
  attribute :school,              String
  attribute :social_media_link,   String
  attribute :snap_chat_name,      String
  attribute :image_data,          Object
  attribute :gender,              String
  attribute :age,                 Integer
  attribute :distance,            Integer
  attribute :allow_male,          Boolean
  attribute :allow_female,        Boolean
  attribute :allow_other,         Boolean

  validates :description, :presence => true
end
