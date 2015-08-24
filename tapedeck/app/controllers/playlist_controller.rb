class PlaylistController < ApplicationController
  def index

  end

  def create
  end

  def show
    @playlist = Playlist.find params[:id]
    @songs = PlaylistSongs.where(:id => @playlist.id)
  end
end
