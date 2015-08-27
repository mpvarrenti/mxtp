class PlaylistController < ApplicationController
  def index
  end

  def new
    playlist_new = Playlist.create
    redirect_to edit_playlist_path(playlist_new)
  end

  def edit

          @playlist = Playlist.find(params[:id])

          if params[:style]
                  if PlaylistStyle.where(playlist_id:@playlist.id).count == 0
                          playlist_style_new = PlaylistStyle.new
                          playlist_style_new.playlist_id = @playlist.id
                          playlist_style_new.background_color = params[:style][:bgcolor]
                          playlist_style_new.color = params[:style][:color]
                          playlist_style_new.save
                  end
          end
          
          if params[:playlist]
            @playlist.title = params[:playlist][:title]
            @playlist.save
          end

          @playlist.title == nil ? @title = "Click here to change title" : @title = @playlist.title

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
    @songs = PlaylistSong.where(playlist_id: @playlist.id).order('created_at DESC')

    @uid = []

    for song in @songs
      play = Spotify.lucky "#{song.song_title}"
      song.song_uid = play[:uid] 
      song.artist_name = play[:artist]
      song.save

      @uid.push(song.song_uid)
    end

      @list_of_songs = @uid.join(",")

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
