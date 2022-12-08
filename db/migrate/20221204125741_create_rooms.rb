class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      # 追加	
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成
      t.integer :member_id #会員ID NOT NULL制約はつけない
      t.integer :admin_id  #管理者ID NOT NULL制約はつけない
      t.integer :ad_mem_message_id   #メッセージID NOT NULL制約はつけない

      t.timestamps
    end
  end
end
