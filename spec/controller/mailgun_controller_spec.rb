require 'rails_helper'

describe MailgunController, :type => :controller  do

	it 'should response 200 for click post call' do
		post 'click', {:recipient => 'test@gmail.com', :ip => '12.121.12.1', :subject => 'test', :event => 'click'}
		expect(response.status).to eq(200)
	end

	it 'should response 200 for bounce post call' do
		post 'click', {:recipient => 'test@gmail.com', :ip => '12.121.12.1', :subject => 'test', :event => 'bounce'}
		expect(response.status).to eq(200)
	end
end