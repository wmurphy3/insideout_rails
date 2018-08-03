class ProfileSerializer < ActiveModel::Serializer
  type :profile
  attributes :email, :description, :interests,
  :job_title, :school,  :name, :age,
  :profile_picture, :allow_male, :allow_female, :gender, :allow_other

  def profile_picture
    object.image_url
  end

end
