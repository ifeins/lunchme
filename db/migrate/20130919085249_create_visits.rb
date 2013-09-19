class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :lunch
      t.references :user
      t.references :restaurant

      t.timestamps
    end

    add_index :visits, :lunch_id
    add_index :visits, :user_id
    add_index :visits, :restaurant_id
  end
end
