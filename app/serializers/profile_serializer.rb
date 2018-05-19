class ProfileSerializer < ActiveModel::Serializer
  type :profile
  attributes :name, :email

end
