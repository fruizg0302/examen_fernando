class ApplicationController < ActionController::Base
  #This allows me to do an API
  protect_from_forgery with: :null_session
end
