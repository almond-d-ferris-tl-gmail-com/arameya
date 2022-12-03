require "test_helper"

class Admin::AdMemMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_ad_mem_messages_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_ad_mem_messages_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_ad_mem_messages_show_url
    assert_response :success
  end
end
