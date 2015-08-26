gem 'rspotify'
gem 'awesome_print'

class PlaylistSong < ActiveRecord::Base
	belongs_to :playlist

	def get
		RSpotify::Track.find(self.song_uid)
	end
	
	def image
		get.album.images[0]["url"]
	end

	def preview
		get.preview_url
	end

	def duration
		get.duration_ms/1000
	end

	def spotify
		get.external_urls["spotify"]
	end
end
