class TransactionController < ApplicationController
  before_action :authenticate

  def new
    @transaction_builder = TransactionBuilder.new(params[:token], params[:amount])
    if @transaction_builder.it_is_an_authorized_credit_card?
      return true
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
