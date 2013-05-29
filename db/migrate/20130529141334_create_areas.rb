class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.float :radius

      t.timestamps
    end
  end
end
