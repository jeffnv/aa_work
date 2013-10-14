class Album < ActiveRecord::Base
  attr_accessible :band_id, :title, :album_type
  validates :band_id, :title, :album_type,  presence: true
  after_initialize :ensure_type
  
  has_many :tracks, dependent: :destroy
  belongs_to :band
  
  def album_types
    [ "Studio", "Live"]
  end
  
  def ensure_type
    self.album_type ||= album_types[0]
  end
end
