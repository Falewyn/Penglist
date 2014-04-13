class PlaylistsController < ApplicationController
	before_action :fetch_playlist, only: [:show, :edit, :update, :toggle_featured]
	before_action :fetch_myplaylists, only: [:index, :show, :myplaylists]
	before_action :require_login, only: [:create, :edit, :update, :delete, :destroy, :add_song, :remove_song]

	def index
		@playlists = Playlist.all
	end

	def show
		@creator = User.find(@playlist.user_id).name
		@songs = @playlist.songs.shuffle
		@songs_id = @songs.map{|x| x.youtube}
		respond_to do |format|
			format.html
			format.json {render json: @playlist}
		end
	end

	def new
		@playlist = Playlist.new
	end	

	def create
		p = Playlist.new
		p.name = params[:playlist][:name]
		p.description = params[:playlist][:description]
		p.user_id = @me.id
		p.featured = false

		if p.save
			flash[:notice] = p.name+" has been added to the database !"
			redirect_to playlists_path
	    else
			flash[:alert] = "There is already a playlist with this name."
			redirect_to new_playlist_path
	    end		
	end	

	def edit
		@playlist = @me.playlists.find(params[:id])
	end	

	def update
		p = @me.playlists.find(params[:id])
		p.name = params[:playlist][:name]
		p.description = params[:playlist][:description]

		if p.save
			flash[:notice] = p.name+" has been modified !"
			redirect_to myplaylists_path
	    else
			flash[:alert] = "This playlist does not belong to you."
			redirect_to myplaylists_path
	    end	
	end	

	def myplaylists
		@playlists = @myplaylists
	end

 	def delete
		@playlist = @me.playlists.find(params[:id])
	end

	def destroy
		@playlist = @me.playlists.find(params[:id])
		@playlist.destroy
		redirect_to myplaylists_path
	end	

	def add_song
		@pl = @me.playlists.find(params[:id])
		@song = Song.find(params[:song_id])
		@pl.songs << @song 
		redirect_to @pl
	end

	def remove_song
		@pl = @me.playlists.find(params[:id])
		@song = Song.find(params[:song_id])
		@pl.songs.delete(@song.id) 
		redirect_to @pl
	end

	def toggle_featured
		@playlist.toggle!(:featured)
		flash[:notice] = "Changement good"
		redirect_to @playlist
	end	

	private

	def fetch_playlist
		@playlist = Playlist.find(params[:id])	
	end

	def require_login
		if current_user
			@me = current_user
		else
		    redirect_to new_user_session_path, notice: 'You need to be logged in to add or edit playlists.'
		end		
	end

	def fetch_myplaylists
		if current_user
			@myplaylists = Playlist.where(user_id: current_user.id)
		end
	end
end
