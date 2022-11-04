class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      # 追加
      t.string :name  # ジャンル名

      t.timestamps
    end
  end
end
