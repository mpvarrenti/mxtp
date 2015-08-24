class AddSongTitleToPlaylistSongs < ActiveRecord::Migration
  def change
	  add_column :playlist_songs, :song_title, :string
  end
end
