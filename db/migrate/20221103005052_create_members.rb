class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      # 追加
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成
      t.integer :review_id             , null: true # レビューID	
      t.integer :business_message_id   , null: false # 会員ー会員メッセージID	
      t.integer :information_message_id, null: false # 管理者ー会員メッセージID	
      t.string  :last_name             , null: false # 姓	
      t.string  :first_name            , null: false # 名	
      t.string  :last_name_kana        , null: false # 姓カナ	
      t.string  :first_name_kana       , null: false # 名カナ	
      t.string  :company               , null: false # 会社名	
      t.string  :department            , null: false # 役職・部署名	
      t.string  :postal_code           , null: false # 郵便番号	
      t.string  :address               , null: false # 住所	
      t.string  :telephone_number      , null: false # 電話番号	
      t.boolean :is_deleted            , null: false, default: false # 退会ステータス	
      
      t.timestamps
    end
  end
end
