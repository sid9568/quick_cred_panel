require "test_helper"

class Superadmin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_users_index_url
    assert_response :success
  end
end
