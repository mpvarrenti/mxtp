class Spotify 
	@spotify = RSpotify::Track
	def self.search params
		search_results = @spotify.search params
		results = []

		for track in search_results
			track_info = {}
			track_info[:name] = track.name
			track_info[:album] = track.album.name
			track_info[:artist] = track.artists[0].name
			track_info[:rank] = track.popularity
			track_info[:uid] = track.id
			results << track_info
		end

		results
	end

	# feelin' lucky search
	def self.lucky name
		search = (@spotify.search name).first
		result = {}
		result[:name] = search.name
		result[:album] = search.album.name
		result[:artist] = search.artists[0].name
		result[:rank] = search.popularity
		result[:uid] = search.id
		result
	end
end
