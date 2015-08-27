class AddSpotifyIndexToPlaylistSong < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :spotify_index, :integer
  end
end
