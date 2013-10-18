class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title, :null => false
      t.string :url, :null => false
      t.string :body, :null => false
      t.integer :submitter_id, :null => false

      t.timestamps
    end
    add_index :links, :submitter_id
  end
end
