class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id,      :null => false
      t.datetime :start_date, :null => false
      t.datetime :end_date,   :null => false
      t.string :status,       :null => false

      t.timestamps
    end
    add_index :cat_rental_requests, :cat_id
  end
end