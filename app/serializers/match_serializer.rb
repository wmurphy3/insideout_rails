class MatchSerializer < ActiveModel::Serializer
  type :match
  attributes :name

  def name
    object.asker_id == user_id ? object.asker.name : object.accepter.name
  end
end
