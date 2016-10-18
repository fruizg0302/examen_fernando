class TokenBuilder
  include TokenGeneratorHelper
  include TextCipherHelper
  attr_reader(:credit_card_number, :expiry_date, :name, :token, :error_message)

  def initialize(credit_card_number, expiry_date, name)
    #Constructor, new hash for global availability
    @credit_card_parameters = {credit_card_number: credit_card_number, expiry_date: expiry_date, name: name}
  end

  def is_a_valid_credit_card?
    regex_credit_card =  /^(([4|5|3]{1})([0-9]{10,11})([0-9]{4}))$/.match(@credit_card_parameters[:credit_card_number])
    if @credit_card_parameters[:credit_card_number] == nil || /^(([4|5|3]{1})([0-9]{10,11})([0-9]{4}))$/.match(@credit_card_parameters[:credit_card_number]) == nil
      @error_message = "invalid credit card"
      return false
    elsif @credit_card_parameters[:name] == "" || @credit_card_parameters[:name] == nil || /^([a-zA-Z\s]{1,})$/.match(@credit_card_parameters[:name]) == nil
      @error_message = "invalid card name"
      return false
    elsif @credit_card_parameters[:expiry_date] == "" || @credit_card_parameters[:expiry_date] == nil || /^(([0-9]{1,2})([\/]{1})([0-9]{1,2}))$/.match(@credit_card_parameters[:expiry_date]) == nil
      @error_message = "invalid expiry date"
      return false
    end
    @regular_expression_first_digit = regex_credit_card[2]
    @regular_expression_last_four_digits = regex_credit_card[4]
    true
  end

  def save
    @token = TokenGeneratorHelper.sec_random_token_generator
    add_issuing_bank_to_parameters()
    add_bin_number_to_parameters()
    add_last_four_digits_to_parameters()
    $redis.set(@token, TextCipherHelper.encrypt(@credit_card_parameters.to_json))
    $redis.expire( @token, 600 )
  end

  def add_issuing_bank_to_parameters
    if @regular_expression_first_digit == '3'
      return @credit_card_parameters[:bank_issuer] = 'Mastercard'
    elsif @regular_expression_first_digit == '5'
      return @credit_card_parameters[:bank_issuer] = 'AMEX'
    elseif @regular_expression_first_digit == '4'
      return @credit_card_parameters[:bank_issuer] = 'VISA'
    else
      nil
    end
  end

  def add_bin_number_to_parameters
    @credit_card_parameters[:bin_number] = /^(([0-9]{6})[0-9]{9,10})$/.match(@credit_card_parameters[:credit_card_number])[2]
  end

  def add_last_four_digits_to_parameters
    @credit_card_parameters[:last_four_digits] = @regular_expression_last_four_digits
  end

end
