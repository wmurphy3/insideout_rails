class UserProfile::Form < Rectify::Form
  mimic :user_profile

  attribute :description,         String
  attribute :favorite_food,       String
  attribute :favorite_song,       Integer
  attribute :favorite_movie,      DateTime
  attribute :job_title,           String
  attribute :best_accomplishment, String
  attribute :hobbies,             String
  attribute :last_school,         String
  attribute :social_media_link,   String
  attribute :snap_chat_name,      String
  attribute :profile_picture,     Object
  attribute :gender,              String
  attribute :age,                 Integer
  attribute :distance,            Integer
  attribute :allow_male,          Boolean
  attribute :allow_female,        Boolean
  attribute :allow_other,         Boolean

  validates :description, :presence => true
end
