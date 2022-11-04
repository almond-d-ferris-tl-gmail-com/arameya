require "test_helper"

class Public::SellOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_sell_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_sell_orders_show_url
    assert_response :success
  end
end
