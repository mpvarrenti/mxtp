class Helper
	def self.to_mins_dec secs
		secs / 60.0
	end

	def self.to_mins_s secs
		mins = secs / 60
		secs = secs % 60
		"#{mins}:#{secs}"
	end
end

