class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string :body, :null => false
      t.integer :author, :null => false
      t.timestamps
    end
    add_index :moments, :author
  end
end
