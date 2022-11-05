class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      # 追加
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成
      t.integer :item_id	, null: false # 商品ID
      t.integer :member_id, null: false # 会員ID	
      t.integer :amount	  , null: false # 数量

      t.timestamps
    end
  end
end
