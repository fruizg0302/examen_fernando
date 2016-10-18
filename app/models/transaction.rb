class Transaction
  include Mongoid::Document
  field :credit_card_name, type: String
  field :bin_number, type: String
  field :last_four_digits, type: String
  field :expiry_date, type: String
  field :issuer, type: String
end
