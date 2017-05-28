class MailgunController < ApplicationController
  def click
  	write_to_csv(params)
  	render_success
  end

  def bounce
  	write_to_csv(params)
  	render_successs
  end

  def render_success
  	render nothing: true, status: 200
  end
end
