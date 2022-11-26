# frozen_string_literal: true

class DeviseCreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      # 追加	
      #id→自動作成(表示されない),email,encrypted_password,created_at,updated_at→自動作成	
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

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :members, :email,                unique: true
    add_index :members, :reset_password_token, unique: true
    # add_index :members, :confirmation_token,   unique: true
    # add_index :members, :unlock_token,         unique: true
  end
end
