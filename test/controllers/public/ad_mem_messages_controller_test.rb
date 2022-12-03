require "test_helper"

class Public::AdMemMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_ad_mem_messages_index_url
    assert_response :success
  end

  test "should get new" do
    get public_ad_mem_messages_new_url
    assert_response :success
  end

  test "should get show" do
    get public_ad_mem_messages_show_url
    assert_response :success
  end
end
