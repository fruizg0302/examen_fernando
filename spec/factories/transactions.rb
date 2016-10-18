FactoryGirl.define do
  factory :transaction do
    credit_card_name "MyString"
    bin_number "MyString"
    last_four_digits "MyString"
    expiry_date "MyString"
    issuer "MyString"
  end
end
