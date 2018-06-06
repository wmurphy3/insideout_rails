class User::Update < Rectify::Command

  def initialize(form, user_profile, user)
    @form = form
    @user_profile = user_profile
    @user = user
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      upload_image
      transform_params
      update_user_profile
    end

    broadcast(:ok, user_profile)
  rescue ActiveRecord::RecordInvalid => e
    broadcast(:invalid, e.messages)
  end

  private

  attr_reader :form, :user, :user_profile

  def upload_image
    # TODO: Use shrine to upload image and then set image_data
  end

  def transform_params
    @transformed_params = {
      email:                form.email,
      name:                 form.name,
      age:                  form.age,
      description:          form.description,
      favorite_movie:       form.favorite_movie,
      favorite_food:        form.favorite_food,
      favorite_song:        form.favorite_song,
      job_title:            form.job_title,
      hobbies:              form.hobbies,
      school:               form.school,
      social_media_link:    form.social_media_link,
      snap_chat_name:       form.snap_chat_name,
      profile_picture:      nil,
      allow_male:           form.allow_male,
      allow_other:          form.allow_other,
      allow_female:         form.allow_female,
      gender:               form.gender
    }
  end

  def update_user_profile
    user_profile.update!(@transformed_params)
  end
end