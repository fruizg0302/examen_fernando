require 'spec_helper'
describe TextCipherHelper do

  let(:simple_string) {
    'This is just simple data'
  }

  describe "It makes the full cycle to cipher and decipher a string" do
    it "ciphers a String" do
      encrypted_string = TextCipherHelper.encrypt(simple_string)
      expect(encrypted_string).to be_truthy
      expect(TextCipherHelper.decrypt(encrypted_string)).to eql('This is just simple data')
    end
  end
end
