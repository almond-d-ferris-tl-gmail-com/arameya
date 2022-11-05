class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      # 追加
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成
      t.integer :genre_id	     , null: false # ジャンルID
      t.integer :review_id	   , null: false # レビューID
      t.string  :name          , null: false # 商品名	
      t.boolean :used_condition, null: false, default: false # 商品状態	
      t.text    :introduction  , null: false # 商品説明文
      t.integer :price         , null: false # 税抜価格	
      t.integer :postage	     , null: false # 送料
      t.integer :sell_status   , null: false, default:0 # 販売ステータス,enumで管理
      
      t.timestamps
    end
  end
end
