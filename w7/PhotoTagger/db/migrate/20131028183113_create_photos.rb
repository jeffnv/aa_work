class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :owner_id, :null => false
      t.string :url, :null => false, :unique => true
      t.string :title, :null => false

      t.timestamps
    end
    add_index :photos, :owner_id
    add_index :photos, :title
  end
end
