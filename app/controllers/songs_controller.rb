class SongsController < ApplicationController
	before_action :require_login, only: [:edit, :update, :create, :new, :mysongs, :delete, :destroy]
	before_action :myplaylists, only: [:index, :show, :index, :mysongs]

	def index
		@songs = Song.all

		respond_to do |format|
			format.html
			format.json {render json: @songs}
		end
	end

	def new
		@song = Song.new
	end	

	def edit
		@song = Song.find(params[:id])
	end

	def show
		@song = Song.find(params[:id])
		@creator = User.find(@song.user_id).name
		@playlists = @song.playlists
	end

	
 	def delete
		@song = current_user.songs.find(params[:id])
	end

	def mysongs
		@songs = Song.where(user_id: @id_user)
	end

	def create
		s = Song.new
		s.name = params[:song][:name]
		s.youtube = params[:song][:youtube]
		s.artist = params[:song][:artist]
		s.length = 0
		s.user_id = @id_user
		s.featured = false

		if s.save
			flash[:notice] = s.name+" has been added to the database !"
			redirect_to songs_path
	    else
			flash[:alert] = "This song is already in the database."
			redirect_to new_song_path
	    end		
	end	


	def update
		s = current_user.songs.find(params[:id])
		s.name = params[:song][:name]
		s.youtube = params[:song][:youtube]
		s.artist = params[:song][:artist]

		if s.save
			flash[:notice] = s.name+" has been modified !"
			redirect_to mysongs_path
	    else
			flash[:alert] = "This song does not belong to you."
			redirect_to mysongs_path
	    end		
	end	


	def destroy
		@song = current_user.songs.find(params[:id])
		@song.destroy
		redirect_to mysongs_path
	end

	private

	def require_login
		if current_user
			@id_user = current_user.id
		else
		    redirect_to new_user_session_path, notice: 'You need to be logged in to add or edit songs.'
		end		
	end

	def myplaylists
		if current_user
			@myplaylists = Playlist.where(user_id: current_user.id)
		end
	end
end
