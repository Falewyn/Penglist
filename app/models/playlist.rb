class Playlist < ActiveRecord::Base
	has_and_belongs_to_many :songs, :uniq => true
	belongs_to :user

	validates :name, presence: true, uniqueness: true
end
