require 'rails_helper'

RSpec.describe TransactionController, type: :controller do

  let(:auth_token) {
    'Token token="d8ee89dddcf84dc28a6bcb7e0aa3341c"'
  }

  describe "POST #new" do
    it "returns http success" do
      request.env['HTTP_AUTHORIZATION'] = auth_token
      post :new
      expect(response).to have_http_status(:success)
    end
  end

end
