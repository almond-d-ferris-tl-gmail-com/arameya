class CreateAdMemMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :ad_mem_messages do |t|
      # 追加	
      #id→自動作成(表示されない),created_at,updated_at→自動作成
      t.integer :room_id   #ルームID NOT NULL制約はつけない
      t.integer :am_mess_title, null: false, default: 0 #メッセージ件名,enumで管理
      t.string  :am_mess_item , null: false #メッセージ商品名
      t.text    :am_mess_body , null: false #メッセージ本文
      t.boolean :am_mess_reply, null: false, default: false #メッセージ対応
      t.boolean :am_mess_speaker, null: false, default: false #メッセージ発言者

      t.timestamps
    end
  end
end
