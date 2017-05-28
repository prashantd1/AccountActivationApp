class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include AuthenticationHelper
  
  def index
  	render html: "Account Activation app"
  end
end
