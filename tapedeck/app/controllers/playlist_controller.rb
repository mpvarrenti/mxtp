class PlaylistController < ApplicationController
  def index
  end

  def new
	  playlist_new = Playlist.create
	  redirect_to edit_playlist_path(playlist_new)
  end

  def edit

	@playlist = Playlist.find(params[:id])

	if params[:playlist]
		@playlist.title = params[:playlist][:title]
		@playlist.save
	end
	
	@playlist.title == nil ? @title = "Untitled" : @title = @playlist.title

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
    @songs = PlaylistSong.where(playlist_id: @playlist.id)
    if params[:notes] != nil
        @songs.notes = params[:notes]
    end
  end

  def destroy
    @playlist = Playlist.find params[:id]
    @playlist.destroy
    redirect_to root_path
  end

end
