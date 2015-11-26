class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected
  
        def authenticate id
            @user = User.find id
            authenticate_or_request_with_http_basic do |name, password|
             authentication = (name == @user.username && password == @user.password)
            end
        end
end
