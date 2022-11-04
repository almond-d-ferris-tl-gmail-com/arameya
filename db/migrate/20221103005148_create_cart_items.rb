class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      # 追加
      t.integer :item_id	  # 商品ID
      t.integer :member_id	# 会員ID
      t.integer :amount	    # 数量

      t.timestamps
    end
  end
end
