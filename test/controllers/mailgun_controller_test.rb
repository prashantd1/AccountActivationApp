require 'test_helper'

class MailgunControllerTest < ActionDispatch::IntegrationTest
  test "should get click" do
    get mailgun_click_url
    assert_response :success
  end

  test "should get bounce" do
    get mailgun_bounce_url
    assert_response :success
  end

end
