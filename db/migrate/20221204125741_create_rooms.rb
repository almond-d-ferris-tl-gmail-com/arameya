class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      # 追加	
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成

      t.timestamps
    end
  end
end
