class TokenBuilder
  def initialize(credit_card_number, name, expiry_date)
    #Constructor, new hash for global availability
    @credit_card_parameters = {credit_card_number: credit_card_number, expiry_date: expiry_date, name: name}
  end

  def is_a_valid_credit_card?
    true
  end

end
