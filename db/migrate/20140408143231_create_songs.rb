class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.integer :length
      t.string :youtube
      t.boolean :featured
      t.integer :user_id

      t.timestamps
    end
  end
end
