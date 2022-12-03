class CreateAdMemMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :ad_mem_messages do |t|
      # 追加	
      #id→自動作成(表示されない),created_at,updated_at→自動作成
      t.integer :member_id #会員ID NOT NULL制約はつけない
      t.integer :admin_id  #管理者ID NOT NULL制約はつけない
      t.integer :am_message_title, null: false, default: 0 #メッセージ件名,enumで管理
      t.string  :am_message_item , null: false #メッセージ商品名
      t.text    :am_message_body , null: false #メッセージ本文
      t.boolean :am_message_reply, null: false, default: false #メッセージ対応

      t.timestamps
    end
  end
end
