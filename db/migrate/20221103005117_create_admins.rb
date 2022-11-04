class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      # 追加
      t.integer :information_message_id	# 管理者ー会員メッセージID
      t.string  :email                	# メールアドレス
      t.string  :encrypted_password     # パスワード

      t.timestamps
    end
  end
end
