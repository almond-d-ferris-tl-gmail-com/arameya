require "test_helper"

class Public::BuyItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_buy_items_index_url
    assert_response :success
  end

  test "should get show" do
    get public_buy_items_show_url
    assert_response :success
  end
end
