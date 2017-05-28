module MailgunHelper
	require 'rest-client'
	require "csv"

	def send_email(email_to, subject, content)
		RestClient.post post_messages_url,
		:from => "Activate Account <mailgun@sandbox351893af32dd4ee0978351bc755c4a4c.mailgun.org>",
	  	:to => email_to,
	  	:subject => subject,
	  	:html => content	
	end

	def get_sent_email_list
		get_logs 'delivered'
	end

	def get_not_clicked_email_list
	   response = get_logs 'delivered and NOT clicked'
	end

	def get_suppression_list
		suppression_list = {
			:bounce => get_bounces,
			:unsubscribes => get_unsubscribes,
			:complaints => get_complaints
		}
	end

	def get_url
		"https://#{Rails.configuration.x.mailgun.api_key}@#{Rails.configuration.x.mailgun.base_url}"
	   #{}"https://api:key-8c3dfd11a669a186bb30177d07e10890@api.mailgun.net/v3/sandbox351893af32dd4ee0978351bc755c4a4c.mailgun.org"
	end

	def post_messages_url
		"#{get_url}/messages"
	end

	def get_complaints
  		restclient_get "#{get_url}/complaints"
	end

	def get_unsubscribes
  		restclient_get "#{get_url}/unsubscribes"
	end

	def get_bounces
  		restclient_get "#{get_url}/bounces"
	end

	def get_logs(event)
	  restclient_get("#{get_url}/events", {
	    :"event" => event
	  })
	end

	def restclient_get(url, param = {})
		response = RestClient.get url,
		  :params => param

		JSON.parse(response.body)
	end

	def write_to_csv(params)
		CSV.open("webhook.csv", "a+") do |csv|
  			csv << [params[:recipient], params[:ip], params[:subject], params[:event]]
		end
	end

end
