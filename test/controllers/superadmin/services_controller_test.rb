require "test_helper"

class Superadmin::ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_services_index_url
    assert_response :success
  end
end
