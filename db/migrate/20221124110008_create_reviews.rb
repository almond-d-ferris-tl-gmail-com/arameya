class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      # 追加	
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成
      t.integer :member_id , null: false # 会員ID
      t.integer :item_id   , null: false # 商品ID
      t.string:review_title, null: false # レビュー件名
      t.text  :review_body , null: false  # レビュー本文
      # t.integer :evaluation_status, null: false # 評価ステータス→enumではなくRatyを使用する
      t.float :star        , null: false, default: 0 # 評価 float→小数点に対応できる

      t.timestamps
    end
  end
end
