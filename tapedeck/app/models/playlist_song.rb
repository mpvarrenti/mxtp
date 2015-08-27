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

	def duration_secs
		get.duration_ms/1000
	end

	def duration_mins_dec
		Helper.to_mins_dec duration_secs
	end

	def duration_mins_s
		Helper.to_mins_s duration_secs
	end

	def spotify
		get.external_urls["spotify"]
	end
end
