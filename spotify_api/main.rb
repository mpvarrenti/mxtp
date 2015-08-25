require 'rspotify'

spot_track = RSpotify::Track
spot_artist = RSpotify::Artist

def list_track name
	spot_track = RSpotify::Track

	search_results = spot_track.search name
	results = {}

	search_results.each do |track|
		results[track.id] = {}
		results[track.id][:album_name] = track.album.name
		results[track.id][:year] = track.album.release_date
		results[track.id][:popularity] = track.popularity
	end

	results
end

class Tracks
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

# params tester class
class PT
	# returns score from which paramater composition can be determined
	def self.test params
		score = 0
		keys = params.keys
		score += 1 if (keys.find_index :name) != nil
		score += 3 if (keys.find_index :artist) != nil
		score += 5 if (keys.find_index :album) != nil
		score
	end

	# check for paricular key in params
	def self.has key, params
		result = false
		result = true if (params.keys.find_index key) != nil
		result
	end
end

test = {name: "I Shot the Sheriff", artist: "Bob Marley", album: "Burnin'"}




require 'pry'
binding.pry
