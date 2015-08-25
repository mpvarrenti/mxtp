require 'pry'
require 'musicbrainz'

#brainz = MusicBrainz::Client.new(:username => 'mpvarrenti', :password => '622123mb')

require 'rspotify'


MusicBrainz.configure do |c|
	c.app_name = "mxtp"
	c.app_version = "0.1"
	c.contact = "mpvarrenti@gmail.com"
end

binding.pry
