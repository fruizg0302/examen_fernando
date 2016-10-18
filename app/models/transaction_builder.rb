class TransactionBuilder
  include TextCipherHelper

  attr_reader(:error_message)

  def initialize(token, amount)
    @internal_parameters = {token: token, amount: amount }
  end

  def it_is_an_authorized_credit_card?
    #If there is a service that asks for black listed credit cards, should be implemented here
    deciphered_hash = redis_decipher(@internal_parameters[:token])
    if deciphered_hash == nil
      @error_message = "Your session ended, try again"
      return false
    end

    if blacklist_service(deciphered_hash["credit_card_number"])
      @error_message = "There is a problem with your card, contact your bank for further information"
      return false
    else
      return true
    end
  end

  def does_the_token_exists?
    if $redis.get(@internal_parameters[:token]) != nil
      return true
    else
      return false
    end
  end

  def blacklist_service(credit_card_number)
    appears_in_black_list = true
    blacklisted_credit_cards = ["4555173000000121", "4098513001237467", "345678000000007"]
    blacklisted_credit_cards.map do |v|
      if v == credit_card_number
        appears_in_black_list = true
      else
        appears_in_black_list = false
      end
    end
    return appears_in_black_list;
 end

 def proceed_with_payload
   #simulating transaction
   #I check once more here is the redis response is nil because if you are out of luck
   #your session is going to end even tho the token existed
   return true
 end

private
  def redis_decipher(token)
    ciphered_information = $redis.get(@internal_parameters[:token])
    if ciphered_information != nil
      deciphered_information = TextCipherHelper.decrypt(ciphered_information)
      JSON.parse(deciphered_information)
    else
      ciphered_information
    end
  end
end
