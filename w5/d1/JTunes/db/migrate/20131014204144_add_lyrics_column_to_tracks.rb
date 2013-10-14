class AddLyricsColumnToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :lyrics, :string
    add_column :albums, :album_type, :string
  end
end
