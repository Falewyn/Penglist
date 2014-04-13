class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|

      t.string :name
      t.boolean :featured
      t.integer :user_id

      t.timestamps
    end
  end
end
