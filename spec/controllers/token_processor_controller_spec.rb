require 'rails_helper'

RSpec.describe TokenProcessorController, type: :controller do

  let(:auth_token) {
    'Token token="d8ee89dddcf84dc28a6bcb7e0aa3341c"'
  }

  let(:credit_card_data){
    {credit_card_number: "4152314005194769",
    name: "Avery Johnson",
    expiry_date: "15/19",
    is_credit: true}
  }

  describe "POST #create" do
    it "returns valid credit card number" do
      request.env['HTTP_AUTHORIZATION'] = auth_token
      post :new, credit_card_data
      expect(response).to have_http_status(:success)
    end
  end

 describe "POST #create" do
   it "returns invalid credit card number" do
     request.env['HTTP_AUTHORIZATION'] = auth_token
     post :new, {:credit_card_number => '023456789012345'}
     expect(response).to have_http_status(:bad_request)
     expect(JSON.parse(response.body)).to include("message" => 'invalid credit card')
   end
 end

 describe "POST #create" do
   it "returns invalid name" do
     request.env['HTTP_AUTHORIZATION'] = auth_token
     credit_card_falsy = credit_card_data.clone
     credit_card_falsy[:name] = "12345"
     post :new, credit_card_falsy
     expect(response).to have_http_status(:bad_request)
     expect(JSON.parse(response.body)).to include("message" => 'invalid card name')
   end
 end

  describe "POST #create" do
   it "returns invalid expiry date data" do
     request.env['HTTP_AUTHORIZATION'] = auth_token
     credit_card_falsy = credit_card_data.clone
     credit_card_falsy[:expiry_date] = "onion"
     post :new, credit_card_falsy
     expect(response).to have_http_status(:bad_request)
     expect(JSON.parse(response.body)).to include("message" => 'invalid expiry date')
   end
  end

  describe "POST #create" do
   it "returns unauthorize status" do
     request.env['HTTP_AUTHORIZATION'] = 'Hi! I am a Hacker'
     post :new, credit_card_data
     expect(response).to have_http_status(:unauthorized)
   end
  end

end
