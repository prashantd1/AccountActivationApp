class User < ApplicationRecord
	require 'rest-client'
  include MailgunHelper
	attr_accessor :remember_token, :activation_token
	before_save { self.email = email.downcase }
	before_create :create_activation_digest
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
	has_secure_password

	validates :password, presence: true, length: { minimum: 6 }

  def authenticated?(attribute, token)
  	digest = send("#{attribute}_digest")
  	return false if digest.nil?
  	BCrypt::Password.new(digest).is_password?(token)
	end

	def activate
  	update_attribute(:activated,    true)
  	update_attribute(:activated_at, Time.zone.now)
	end

	def send_activation_email
    content = "<h1> Welcome #{name} </h1>"
    content << "<p> please activate your account by clicking this #{Rails.configuration.x.app.callback_url}/account_activations/#{activation_token}/edit?email=#{email}</p>"
    #content << ""

    send_email(email, 'Activate your account', content)
  # -s --user 'api:8c3dfd11a669a186bb30177d07e10890' https://api.mailgun.net/v3/sandbox351893af32dd4ee0978351bc755c4a4c.mailgun.org/messages -F from='Excited User <mailgun@sandbox351893af32dd4ee0978351bc755c4a4c.mailgun.org>' -F to=dindure.prashant@gmail.com -F subject='Hello' -F text='Testing some Mailgun awesomness!'
	end


	def forget
    update_attribute(:remember_digest, nil)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
    	SecureRandom.urlsafe_base64
	end

	def remember
  	self.remember_token = User.new_token
 		update_attribute(:remember_digest, User.digest(remember_token))
	end

	private 

	def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
