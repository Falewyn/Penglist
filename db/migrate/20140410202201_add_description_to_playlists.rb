class AddDescriptionToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :description, :string
  end
end
