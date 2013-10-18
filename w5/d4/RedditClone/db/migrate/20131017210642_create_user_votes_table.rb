class CreateUserVotesTable < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :link_id, null: false
      t.integer :voter_id, null: false
      t.integer :vote, null: false
    end

    add_index :user_votes, :link_id
    add_index :user_votes, :voter_id
  end
end

