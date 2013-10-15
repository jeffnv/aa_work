class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :track_id, :null => false
      t.integer :user_id, :null => false
      t.string :body, :null => false

      t.timestamps
    end
    
    add_index :notes, [:track_id, :user_id]
  end
end
