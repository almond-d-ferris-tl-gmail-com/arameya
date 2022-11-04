class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      # 追加
      t.integer :member_id    # 会員ID
      t.string  :postal_code	# 郵便番号
      t.string  :address	    # 住所
      t.string  :name       	# 宛名

      t.timestamps
    end
  end
end
