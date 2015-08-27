class PlaylistSongController < ApplicationController

	def edit
		# get song
		@song = PlaylistSong.find params[:id]

		# if loop for fix artist
		if params[:commit] = "Fix Artist"
			# get song
			@song = PlaylistSong.find params[:song_id]
			# advance spotify song index 
			@song.spotify_index += 1 
			# get songs from spotify
			songs_spotify = Spotify.search @song.song_title
			# get song at spotify_song_index
			song_spotify = songs_spotify[@song.spotify_index]
			# continue steping thru until new artist found
			until song_spotify[:artist] != @song.artist_name do
				# advance spotify song index
				@song.spotify_index += 1
				# get next spotify song
				song_spotify = songs_spotify[@song.spotify_index]
			end
			# update song artist and save
			@song.artist_name = song_spotify[:artist]
			@song.save
		end
		
		# if loop for add note
		
		# if loop for style note
		#render plain: params.inspect
		redirect_to edit_playlist_path(Playlist.find(@song.playlist_id))
	end

	def update
		@song = PlaylistSong.find params[:id]
		@song.notes = params[:notes]
		@song.save
		redirect_to playlist_path @song.playlist_id
	end

	def destroy
		@song = PlaylistSong.find params[:id]
		@song.destroy
		redirect_to "/playlist/#{@song.playlist_id}"
	end

end
