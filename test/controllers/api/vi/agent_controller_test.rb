require "test_helper"

class Api::Vi::AgentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_vi_agent_index_url
    assert_response :success
  end
end
