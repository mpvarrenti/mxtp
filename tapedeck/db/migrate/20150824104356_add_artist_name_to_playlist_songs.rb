class AddArtistNameToPlaylistSongs < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :artist_name, :string
  end
end
