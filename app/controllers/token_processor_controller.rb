class TokenProcessorController < ApplicationController
  def new
    @token_builder = TokenBuilder.new(params[:credit_card_number], params[:expiry_date], params[:name])
    if !@token_builder.is_a_valid_credit_card?
      return render json: {:message => @token_builder.error_message}, status: :bad_request
    end
    if @token_builder.save
      return render json: {:token => "#{@token_builder.token}"}, status: :ok
    end
  end
end
