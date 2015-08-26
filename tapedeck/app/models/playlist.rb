class Playlist < ActiveRecord::Base
	def songs
		PlaylistSong.where(playlist_id:self.id)
	end
end
