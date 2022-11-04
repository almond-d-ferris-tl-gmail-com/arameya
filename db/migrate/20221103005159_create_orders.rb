class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # 追加
      t.integer :member_id    	# 会員ID
      t.string  :postal_code	  # 配送先郵便番号
      t.string  :address	      # 配送先住所
      t.string  :name         	# 配送先氏名
      t.integer :shipping_cost	# 送料
      t.integer :total_payment	# 請求額
      t.integer :payment_method	# 支払方法
      t.integer :order_status	  # 受注ステータス

      t.timestamps
    end
  end
end
