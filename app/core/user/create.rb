class User::Create < Rectify::Command

  def initialize(form, user)
    @form = form
    @user = user
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      transform_params
      create_user_profile
    end

    if user_profile.persisted?
      broadcast(:ok, user_profile)
    else
      broadcast(:invalid, user_profile.errors.messages)
    end
  end

  private

  attr_reader :form, :user, :user_profile

  def transform_params
    @transformed_params = {
      email:                form.email,
      name:                 form.name,
      age:                  form.age,
      password:             form.password,
      description:          form.description,
      job_title:            form.job_title,
      school:               form.school,
      interests:            form.interests,
      image_data:           nil,
      allow_male:           form.allow_male,
      allow_other:          form.allow_other,
      allow_female:         form.allow_female,
      gender:               form.gender,
    }
  end

  def create_user_profile
    @user_profile = User.new(@transformed_params)
    @user_profile.save
  end
end
