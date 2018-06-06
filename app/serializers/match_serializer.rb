class MatchSerializer < ActiveModel::Serializer
  type :match
  attributes :name, :age, :user_id

  def name
    object.asker_id == instance_options[:user_id] ? object.accepter.name : object.asker.name
  end

  def age
    object.asker_id == instance_options[:user_id] ? object.accepter.age : object.asker.age
  end

  def user_id
    object.asker_id == instance_options[:user_id] ? object.accepter_id : object.asker_id
  end
end
