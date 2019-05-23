require 'test_helper'

class AdvicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get advices_index_url
    assert_response :success
  end

end
