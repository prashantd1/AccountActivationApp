require 'rails_helper'

describe AccountActivationsController, :type => :controller  do
	before do
		@user = build(:user, :id => 1, :name => "Test", :email => "test@gmail.com", :password_digest => User.digest("test123"), :activation_digest => User.digest("1234567"), :activated => false)
		User.stub :find_by => @user
	end

	it 'Should set active flag true and redirect to user page' do
		controller.stub(:params).and_return({:email => 'test@gmail.com', :id => '1234567'})
		get 'edit', {:email => 'test@gmail.com', :id => '1234567'}
		expect(@user.activated).to be true
		response.should redirect_to @user
	end

	it 'Should set active flag false and redirect to root page' do
		controller.stub(:params).and_return({:email => 'test@gmail.com', :id => '123456'})
		get 'edit', {:email => 'test@gmail.com', :id => '123456'}
		expect(@user.activated).to be false
		response.should redirect_to 'http://test.host/'
	end


end