class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :lunch
      t.references :user
      t.references :restaurant

      t.timestamps
    end
    add_index :votes, :lunch_id
    add_index :votes, :user_id
    add_index :votes, :restaurant_id
  end
end
