require "test_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get services_index_url
    assert_response :success
  end

  test "should get edit" do
    get services_edit_url
    assert_response :success
  end

  test "should get update" do
    get services_update_url
    assert_response :success
  end
end
