require 'rails_helper'

RSpec.describe TokenProcessorController, type: :controller do

  let(:credit_card_data){
    {credit_card_number: "523456799012334",
    name: "Avery Johnson",
    expiry_date: "15/19",
    is_credit: true}
  }

  describe "POST #new" do
    it "returns a valid token" do
      post :new, credit_card_data
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
   it "returns invalid request" do
     post :new, {:credit_card_number => '023456789012345'}
     expect(response).to have_http_status(:bad_request)
     expect(JSON.parse(response.body)).to include("message" => 'invalid credit card')
   end
 end




end
