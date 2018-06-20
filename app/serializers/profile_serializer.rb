class ProfileSerializer < ActiveModel::Serializer
  type :profile
  attributes :email, :description, :favorite_movie, :favorite_food, :favorite_song,
  :job_title, :hobbies, :school, :social_media_link, :name, :age,
  :snap_chat_name, :profile_picture, :allow_male, :allow_female, :gender, :allow_other

  def profile_picture
    object.image_url
  end

end
