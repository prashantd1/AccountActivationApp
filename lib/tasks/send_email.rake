namespace :send_email do

  include MailgunHelper
  desc "Sends followup email for activation"
  task send_followup_email: :environment do
  	email_list = get_not_clicked_email_list
  	if(!email_list.nil? && !email.list.empty? && email_list.key?("items")) do
  		email_address = email_list["items"].each{|email| emal["recipient"]}
  		users = User.where(:email => email_address)
	  	users.each do |user|
	  		content = "<h1> #{user.name} </h1>"
	  		content << "<p> we still havent seen your account activated </p>"
	  		send_email(user.email, "Waiting to hear from you", content)
	  	end
	end
  end

end
