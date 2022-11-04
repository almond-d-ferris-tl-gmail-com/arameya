class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      # 追加
      t.integer :review_id              # レビューID
      t.integer :business_message_id    # 会員ー会員メッセージID
      t.integer :information_message_id # 管理者ー会員メッセージID
      t.string  :last_name              # 姓
      t.string  :first_name             # 名
      t.string  :last_name_kana         # 姓カナ
      t.string  :first_name_kana        # 名カナ
      t.string  :company                # 会社名
      t.string  :department             # 役職・部署名
      t.string  :postal_code            # 郵便番号
      t.string  :address                # 住所
      t.string  :telephone_number       # 電話番号
      t.string  :email                  # メールアドレス
      t.string  :encrypted_password     # パスワード
      t.boolean :is_deleted             # 退会ステータス

      t.timestamps
    end
  end
end
