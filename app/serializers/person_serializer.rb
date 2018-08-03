class PersonSerializer < ActiveModel::Serializer
  type :person

  attributes :id, :description, :name, :age, :interests,
    :job_title, :school, :gender, :allow_other,
    :profile_picture, :allow_male, :allow_female, :distance, :matched

  def distance
    object.distance_from([instance_options[:latitude], instance_options[:longitude]])
  end

  def gender
    object.gender.first
  end

  def profile_picture
    object.image_url
  end

  def matched
    Match.matched(object.id, instance_options[:user_id])
  end

end
