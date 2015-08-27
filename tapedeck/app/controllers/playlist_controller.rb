class PlaylistController < ApplicationController
                
	# playlist#index is the current root route
        def index
        end

        def new
		# create a new blank playlist
                playlist = Playlist.create
                redirect_to edit_playlist_path playlist
        end

        def edit
		# get relevant playlist
                @playlist = Playlist.find params[:id]

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
			# set song title
			song.song_title = params[:new_song][:song_title]
			# get lucky with spotify
			song_spotify = Spotify.lucky song.song_title 
			# set remaining song properties and save
                        song.playlist_id = @playlist.id
                        song.artist_name = song_spotify[:artist] 
			song.song_uid = song_spotify[:uid]
			song.spotify_index = 0
                        song.save
                end

		# gather all songs for current playlist
                @songs = @playlist.songs
        end

        def show
		# get relevant playlist
                @playlist = Playlist.find params[:id]

		# gather songs for playlist
                @songs = PlaylistSong.where(playlist_id: @playlist.id).order('created_at DESC')

		# initialize empty array for collecting song uids
                @songs_uid = []

		# iterate over playlist songs
                for song in @songs
			# tell spotify that you're feelin' lucky
                        spotify = Spotify.lucky "#{song.song_title}"

			#update song properties based on spotify result and save
                        song.song_uid = spotify[:uid] 
                        song.artist_name = spotify[:artist]
                        song.save

			# add song uid to array
                        @songs_uid << song.song_uid
                end

		# join song uids as list_of_songs
                @list_of_songs = @songs_uid.join(",")

                if params[:notes] != nil
                        @songs.notes = params[:notes]
                end
        end 

        def destroy
		# get relevant playlist and destroy
                @playlist = Playlist.find params[:id]
                @playlist.destroy
                redirect_to root_path
        end
end
