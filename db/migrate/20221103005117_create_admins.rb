class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      # 追加
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成
      t.integer :information_message_id, null: true # 管理者ー会員メッセージID

      t.timestamps
    end
  end
end
