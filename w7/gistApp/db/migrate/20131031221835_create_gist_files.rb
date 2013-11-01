class CreateGistFiles < ActiveRecord::Migration
  def change
    create_table :gist_files do |t|
      t.string :name, null: false
      t.text :body, null: false
      t.integer :gist_id, null: false

      t.timestamps
    end
    add_index :gist_files, :gist_id
  end
end
