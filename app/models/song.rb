class Song < ActiveRecord::Base
	has_and_belongs_to_many :playlists, :uniq => true
	belongs_to :user

	validates :name, :youtube, :artist, presence: true
	validates :youtube, uniqueness: true
	validates :youtube, length: { is: 11 }	
end
