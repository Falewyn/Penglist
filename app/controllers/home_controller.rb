class HomeController < ApplicationController
	def index
		@playlists = Playlist.where(featured: true).limit(3)
	end
end
