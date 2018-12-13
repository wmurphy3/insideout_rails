class User::Update < Rectify::Command

  def initialize(form, user_profile, user)
    @form = form
    @user_profile = user_profile
    @user = user
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      transform_params
      update_user_profile
    end

    broadcast(:ok, user_profile)
  rescue ActiveRecord::RecordInvalid => e
    broadcast(:invalid, e.messages)
  end

  private

  attr_reader :form, :user, :user_profile

  def transform_params
    @transformed_params = {
      email:                form.email,
      name:                 form.name,
      age:                  form.age,
      description:          form.description,
      job_title:            form.job_title,
      school:               form.school,
      interests:            form.interests,
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
