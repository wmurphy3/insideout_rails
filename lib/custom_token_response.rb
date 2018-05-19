module CustomTokenResponse
  def body
    return super unless @token.resource_owner_id

    user = User.find(@token.resource_owner_id)

    additional_data = {
      :id               => user.id,
      :email            => user.email
    }

    # call original `#body` method and merge its result with the additional data hash
    super.merge(additional_data)
  end
end
