class PersonSerializer < ActiveModel::Serializer
  type :person

  attributes :id, :description, :name, :age, :favorite_movie, :favorite_food, :favorite_song,
    :job_title, :hobbies, :school, :social_media_link, :gender, :allow_other,
    :snap_chat_name, :profile_picture, :allow_male, :allow_female, :distance

  def distance
    object.distance_from([instance_options[:latitude], instance_options[:longitude]])
  end

  def gender
    object.gender.first 
  end

end
