require 'rails_helper'

RSpec.describe TokenProcessorController, type: :controller do

  let(:credit_card_data){
    {credit_card_number: "123456789012345",
    name: "Avery Johnson",
    expiry_date: "00/00",
    is_credit: true}
  }


  describe "GET #new" do
    it "returns a valid token" do
      post :new, credit_card_data
      expect(response).to have_http_status(:success)
    end
  end

end
