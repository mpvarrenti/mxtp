class AddNotesToPlaylistSong < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :notes, :string
  end
end
