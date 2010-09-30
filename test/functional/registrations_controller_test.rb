require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "should get quick" do
    get :quick
    assert_response :success
  end

end
