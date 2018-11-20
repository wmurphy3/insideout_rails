class User::Create < Rectify::Command
  require "stripe"

  def initialize(form, user)
    @form = form
    @user = user
    Stripe.api_key = ENV['STRIPE_KEY']
  end

  def call
    return broadcast(:invalid, form.errors.messages) if form.invalid?

    transaction do
      transform_card
      transform_params
      create_user_profile
      create_customer
      charge_account
    end

    if user_profile.persisted?
      broadcast(:ok, user_profile)
    else
      broadcast(:invalid, user_profile.errors.messages)
    end
  end

  private

  attr_reader :form, :user, :user_profile, :customer, :stripe_card_id, :card

  def transform_card
    @card = {
      number:       form.number,
      cvc:          form.cvc,
      exp_month:    form.exp_month,
      exp_year:     form.exp_year,
      address_zip:  form.address_zip
    }
  end

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
      stripe_id:            Stripe::Customer.create(email: form.email).id
    }
  end

  def create_user_profile
    @user_profile = User.new(@transformed_params)
    @user_profile.save
  end

  def create_customer
    @stripe_card_id = CreditCardService.new(@user_profile, card).create_credit_card
  end

  def charge_account
    Stripe::Charge.create(
      customer: user_profile.stripe_id,
      source:   stripe_card_id,
      amount:   1000,
      currency: 'usd'
    )
  end
end
