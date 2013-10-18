class CreateLinkSubs < ActiveRecord::Migration
  def change
    create_table :link_subs do |t|
      t.integer :link_id, :null => false
      t.integer :sub_id, :null => false

      t.timestamps
    end
  end
end
