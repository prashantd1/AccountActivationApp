require 'rails_helper'

describe AuthenticationController, :type => :controller  do

	before do
		@user = build(:user, :id => 1, :name => "Test", :email => "test@gmail.com", :password_digest => User.digest("test123"))
		User.stub :find_by => @user
	end
	it 'Should redirect to root page for inactive account' do
		

		controller.stub(:params).and_return({:session => {:email => 'test@gmail.com', :password => 'test123'}})
		post 'create', {:session => {:email => "test1@gmail.com", :password => "test123"}}

		response.should redirect_to 'http://test.host/'
	end


	it 'Should redirect to registration page for incorrect password' do

		controller.stub(:params).and_return({:session => {:email => 'test@gmail.com', :password => 'test12'}})
		post 'create', {:session => {:email => "test1@gmail.com", :password => "test12"}}

		expect(response).to render_template("new")
	end
end