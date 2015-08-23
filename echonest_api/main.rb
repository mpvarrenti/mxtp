require 'pry'
require 'echonest-ruby-api'

artist = Echonest::Artist.new('RI81LPIDJIGZGTO0O', 'The Prodigy')

song = Echonest::Song.new('RI81LPIDJIGZGTO0O')

binding.pry
