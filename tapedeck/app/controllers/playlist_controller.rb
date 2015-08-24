class PlaylistController < ApplicationController
  def index
  end

  def new
	playlist_new = Playlist.find(1)
	playlist_new_songs = PlaylistSong.where(playlist_id:1)
	
	
  end

  def create
  end

  def show
    @playlist = Playlist.find params[:id]
    @songs = PlaylistSong.where(playlist_id: @playlist)
  end
end
