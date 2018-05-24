class MessageSerializer < ActiveModel::Serializer
  type :message
  attributes :_id, :text, :createdAt, :user

  def _id
    object.id
  end
  
  def text
    object.message
  end

  def createdAt
    object.created_at
  end

  def user
    {
      _id: object.user_id,
      name: object.user.name,
      avatar: nil
    }
  end
end
