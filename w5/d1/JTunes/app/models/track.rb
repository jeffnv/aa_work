class Track < ActiveRecord::Base
  attr_accessible :album_id, :title, :lyrics
  validates :album_id, :title, :lyrics,  presence: true
  
  belongs_to :album
  has_many :notes
end
