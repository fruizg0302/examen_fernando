class CreditCard
  include Mongoid::Document
  field :credit_card_number, type: String
  field :expiry_date, type: String
  field :issuer, type: String
  field :credit_card_scheme, type: String
  field :credit_card_bin_number, type: String
  field :credit_card_last_four_digits, type: String
end
