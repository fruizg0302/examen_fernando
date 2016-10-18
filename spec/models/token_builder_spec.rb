require 'rails_helper'

RSpec.describe TokenBuilder, type: :model do

  it "returns a valid credit card" do
    token_builder = TokenBuilder.new("523456789012345", "05/22", "Jack Bauer", "123")
    expect(token_builder.is_a_valid_credit_card?).to be true
  end

  it "returns an invalid credit card number" do
    token_builder = TokenBuilder.new("123456789012345", "05/22", "Jack Bauer", "123")
    expect(token_builder.is_a_valid_credit_card?).to be false
  end

  it "returns a valid bank issuer" do
    token_builder = TokenBuilder.new("523456789012345", "05/22", "Jack Bauer", "123")
    token_builder.is_a_valid_credit_card?
    expect(token_builder.add_issuing_bank_to_parameters).to eql("MasterCard")
  end
end
