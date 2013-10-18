class AddAuthorIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :author_id, :integer
    change_column :comments, :author_id, :integer, :null => false
  end
end
