class PlaylistController < ApplicationController
                
        def index
        end

        def new
		# create a new blank playlist
                playlist = Playlist.create
                redirect_to edit_playlist_path(playlist)
        end

        def edit
		# get relevant playlist
                @playlist = Playlist.find(params[:id])

		# update style record if such paramaters exist
                if params[:style]
			# create a new playlist_style record where none exists
                        if PlaylistStyle.where(playlist_id:@playlist.id).count == 0
                                playlist_style = PlaylistStyle.new
                                playlist_style.playlist_id = @playlist.id
			# otherwise get existing record
			else
				playlist_style = PlaylistStyle.where(playlist_id:@playlist.id)
			end

			# set playlist_style properties and save
			playlist_style.background_color = params[:style][:bgcolor]
			playlist_style.color = params[:style][:color]
			playlist_style.save
                end

		# set title
                if params[:playlist]
                        @playlist.title = params[:playlist][:title]
                        @playlist.save
                end

                @playlist.title == nil ? @title = "Untitled" : @title = @playlist.title

		# add new song to playlist
                if params[:new_song]
			# new blank song
                        song= PlaylistSong.new

			# set song properties and save
                        song.playlist_id = @playlist.id
                        song.song_title = params[:new_song][:song_title]
                        song.artist_name = params[:new_song][:artist_name]
                        song.save
                end

		# gather all songs for current playlist
                @songs = @playlist.songs
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
