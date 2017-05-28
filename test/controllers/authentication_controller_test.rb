require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get authentication_new_url
    assert_response :success
  end

end
