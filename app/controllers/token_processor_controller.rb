class TokenProcessorController < ApplicationController
  before_action :authenticate

  def new
    @token_builder = TokenBuilder.new(params[:credit_card_number], params[:expiry_date], params[:name])
    if !@token_builder.is_a_valid_credit_card?
      return render json: {:message => @token_builder.error_message}, status: :bad_request
    end
    if @token_builder.save
      return render json: {:token => "#{@token_builder.token}"}, status: :ok
    end
  end


  protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_or_request_with_http_token do |token, options|
        begin
          CommercialEntity.find_by(auth_token: token)
        rescue
          return nil
        end
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Conekta"'
      render json: {:message=> 'Bad credentials'}, status: 401
    end
end
