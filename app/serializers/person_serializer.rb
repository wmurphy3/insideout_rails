class PersonSerializer < ActiveModel::Serializer
  type :person
  attributes :id, :description, :name, :age

end
