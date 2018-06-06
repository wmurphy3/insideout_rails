module CustomTokenResponse
  def body
    return super unless @token.resource_owner_id

    user = User.find(@token.resource_owner_id)

    additional_data = {
      :id               => user.id,
      :email            => user.email,
      :description      => user.description,
      :age              => user.age,
      :name             => user.name,
      :subscribed       => user.subscribed,
      :favorite_food    => user.favorite_food,
      :favorite_song    => user.favorite_song,
      :favorite_movie   => user.favorite_movie,
      :job_title        => user.job_title,
      :hobbies          => user.hobbies,
      :school           => user.social_media_link,
      :snap_chat_name   => user.snap_chat_name,
      :gender           => user.gender,
      :allow_male       => user.allow_male,
      :allow_female     => user.allow_female,
      :allow_other      => user.allow_other
    }

    # call original `#body` method and merge its result with the additional data hash
    super.merge(additional_data)
  end
end
