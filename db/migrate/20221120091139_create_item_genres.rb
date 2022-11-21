class CreateItemGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :item_genres do |t|
      t.references :item, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
