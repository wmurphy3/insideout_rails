class ProfileSerializer < ActiveModel::Serializer
  type :profile
  attributes :description, :favorite_movie, :favorite_food, :favorite_song,
  :job_title, :best_accomplishment, :hobbies, :last_school, :social_media_link,
  :snap_chat_name, :profile_picture, :allow_male, :allow_female, :gender, :distance,
  :allow_other

end
