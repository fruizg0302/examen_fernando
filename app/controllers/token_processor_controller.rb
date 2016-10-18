class TokenProcessorController < ApplicationController
  def new
    @token_builder = TokenBuilder.new(params[:credit_card_number], params[:name], params[:expiry_date],)
    if @token_builder.is_a_valid_credit_card?
      return render json: {:token => "This is a valid token"}, status: :ok
    end
  end
end
