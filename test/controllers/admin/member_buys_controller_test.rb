require "test_helper"

class Admin::MemberBuysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_member_buys_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_member_buys_show_url
    assert_response :success
  end
end
