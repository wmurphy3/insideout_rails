class CreditCardService
  def initialize(user, card)
    @user = user
    @card = card
  end

  def create_credit_card
    customer = Stripe::Customer.retrieve(@user.stripe_id)
    customer.sources.create(source: generate_token).id
  end

  def generate_token
    Stripe::Token.create(
      card: {
        number:     @card[:number].delete(' '),
        exp_month:  @card[:exp_month],
        exp_year:   @card[:exp_year],
        cvc:        @card[:cvc]
      }
    ).id
  end
end
