class PlaylistSongController < ApplicationController

  def update
    @song = PlaylistSong.find params[:id]
    @song.notes = params[:notes]
    @song.save
    redirect_to "/playlist/#{@song.playlist_id}"
  end

  def destroy
    @song = PlaylistSong.find params[:id]
    @song.destroy
    redirect_to "/playlist/#{@song.playlist_id}"
  end

end