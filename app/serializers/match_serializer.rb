class MatchSerializer < ActiveModel::Serializer
  type :match
  attributes :name, :age

  def name
    object.asker_id == instance_options[:user_id] ? object.asker.name : object.accepter.name
  end

  def age
    object.asker_id == instance_options[:user_id] ? object.asker.age : object.accepter.age
  end
end
