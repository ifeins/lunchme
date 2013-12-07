class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      t.references :location

      t.timestamps
    end
    add_index :offices, :location_id


  end
end
