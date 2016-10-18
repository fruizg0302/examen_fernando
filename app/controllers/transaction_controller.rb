class TransactionController < ApplicationController
  before_action :authenticate

  def new

    if params[:token] == nil || params[:token] == "" || params[:amount] == nil || params[:amount] == ""
      return render json: {:message => "bad request"}, status: :bad_request
    end

    @transaction_builder = TransactionBuilder.new(params[:token], params[:amount])
    if @transaction_builder.it_is_an_authorized_credit_card? && @transaction_builder.does_the_token_exists?
      if @transaction_builder.proceed_with_payload
        return render json: {:message => "Thanks for your purchase"}, status: :ok
      else
        return render json: {:message => @transaction_builder.error_message}, status: :bad_request
      end  
    else
      return render json: {:message => @transaction_builder.error_message}, status: :bad_request
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
