class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthenticationHelper
  
  def index
  	render html: "hello world"
  end
end
