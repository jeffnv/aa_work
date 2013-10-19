class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :goal_info, null: false
      t.string :status, null: false
      t.string :visibility, null: false
      t.timestamps
    end
    
    add_index :goals, :user_id
  end
end
