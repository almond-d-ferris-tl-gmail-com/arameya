class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      # 追加
      t.integer :item_id	# 商品ID
      t.integer :order_id	# 注文ID
      t.integer :price	# 購入時価格(税込)
      t.integer :amount	# 数量
      t.integer :arranging_status	# 準備ステータス

      t.timestamps
    end
  end
end
