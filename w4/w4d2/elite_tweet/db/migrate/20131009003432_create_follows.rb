class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :twitter_follower_id, :null => false
      t.integer :twitter_followee_id, :null => false

      t.timestamps
    end

    add_index :follows, [:twitter_follower_id, :twitter_followee_id], :unique => true
  end
end
