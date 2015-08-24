class PlaylistController < ApplicationController
  def index

  end

  def create
	@playlist = Playlist.find(2)

	if params[:new_song]
		song_new = PlaylistSong.new
		song_new.playlist_id = @playlist.id
		song_new.song_title = params[:new_song][:song_title]
		song_new.artist_name = params[:new_song][:artist_name]
		song_new.save
	end

	@songs = PlaylistSong.where(playlist_id:@playlist.id)
  end

  def show
    @playlist = Playlist.find params[:id]
    @songs = PlaylistSongs.where(:id => @playlist.id)
  end
end
