require 'rails_helper'

RSpec.describe TransactionBuilder, type: :model do

  it "returns a whitelisted credit card" do
    token_builder = TokenBuilder.new("523456789012345", "05/22", "Jack Bauer")
    token_builder.save
    transaction_builder = TransactionBuilder.new(token_builder.token, "1200")
    expect(transaction_builder.it_is_an_authorized_credit_card?).to be true
  end

  it "returns a blacklisted credit card" do
    token_builder = TokenBuilder.new("345678000000007", "05/22", "Jack Bauer")
    token_builder.save
    transaction_builder = TransactionBuilder.new(token_builder.token, "1200")
    expect(transaction_builder.it_is_an_authorized_credit_card?).to be true
  end
end
