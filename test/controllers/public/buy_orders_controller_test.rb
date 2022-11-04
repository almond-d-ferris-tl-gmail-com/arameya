require "test_helper"

class Public::BuyOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_buy_orders_new_url
    assert_response :success
  end

  test "should get comfirm" do
    get public_buy_orders_comfirm_url
    assert_response :success
  end

  test "should get complete" do
    get public_buy_orders_complete_url
    assert_response :success
  end

  test "should get index" do
    get public_buy_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_buy_orders_show_url
    assert_response :success
  end
end
