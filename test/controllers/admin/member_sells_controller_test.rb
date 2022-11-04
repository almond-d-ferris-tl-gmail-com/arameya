require "test_helper"

class Admin::MemberSellsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_member_sells_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_member_sells_show_url
    assert_response :success
  end
end
