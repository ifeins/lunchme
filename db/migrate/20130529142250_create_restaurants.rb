class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.references :location
      t.references :area

      t.timestamps
    end
    add_index :restaurants, :location_id
    add_index :restaurants, :area_id
  end
end
