class TransactionBuilder
  include TextCipherHelper

  def initialize(token, amount)
    @internal_parameters = {token: token, amount: amount }
  end

  def it_is_an_authorized_credit_card?
    #If there is a service that asks for black listed credit cards, should be implemented here
    ciphered_information = $redis.get(@internal_parameters[:token])
    deciphered_information = TextCipherHelper.decrypt(ciphered_information)
    deciphered_information_in_hash = JSON.parse(deciphered_information)
    blacklist_service(deciphered_information_in_hash["credit_card_number"])
  end

  #private

  def blacklist_service(credit_card_number)
    blacklisted_credit_cards = ["4555173000000121", "4098513001237467", "345678000000007"]
    blacklisted_credit_cards.map do |v|
      if v == credit_card_number
        return false
      else
        return true
      end
    end
  end

end
