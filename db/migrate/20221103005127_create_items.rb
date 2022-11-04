class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      # 追加
      t.integer :genre_id	      # ジャンルID
      t.integer :review_id	    # レビューID
      t.string  :name         	# 商品名
      t.boolean :used_condition	# 商品状態	
      t.text    :introduction	  # 商品説明文
      t.integer :price        	# 税抜価格
      t.integer :postage	      # 送料
      t.integer :sell_status  	# 販売ステータス		

      t.timestamps
    end
  end
end
