class AddSongUidToPlaylistSongs < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :song_uid, :string
  end
end
