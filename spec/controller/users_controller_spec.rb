require 'rails_helper'

describe UsersController, :type => :controller  do

	before do
      @user = build(:user, :id => 1, :name => "Test", :email => "test@gmail.com", :password_digest => "test")
      stub_request(:post, /api.mailgun.net/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'rest-client/2.0.2 (mingw32 i686) ruby/2.2.6p396'}).
      to_return(status: 200, body: "stubbed response", headers: {})
    end

	it 'render registration page' do
		get 'new'

		expect(response).to render_template("new")
	end

	it 'should render users show page' do
		post 'create', {:user => {:name => "Test", :email => "test@gmail.com", :password => "test123", :password_confirmation => "test123"}}
		get 'show', {:id => 1}
	end

	it 'should render root page' do
		post 'create', {:user => {:name => "Test", :email => "test@gmail.com", :password => "test123", :password_confirmation => "test123"}}

		response.should redirect_to 'http://test.host/'
	end

	it 'should render registration page on invalid data' do
		post 'create', {:user => {:name => "Test", :email => "test@gmail.com", :password => "test", :password_confirmation => "test123"}}

		expect(response).to render_template("new")
	end
end
