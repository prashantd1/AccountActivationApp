class MailgunController < ApplicationController
  include MailgunHelper

  skip_before_action :verify_authenticity_token
  def click
  	write_to_csv(params)
  	render_success
  end

  def bounce
  	write_to_csv(params)
  	render_success
  end

  def render_success
  	render nothing: true, status: 200
  end
end
