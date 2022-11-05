class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      # 追加
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成
      t.integer :item_id         , null: false # 商品ID	
      t.integer :order_id        , null: false # 注文ID	
      t.integer :price	         , null: false # 購入時価格(税込)
      t.integer :amount          , null: false # 数量	
      t.integer :arranging_status, null: false # 準備ステータス,enumで管理

      t.timestamps
    end
  end
end
