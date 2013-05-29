class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :area

      t.timestamps
    end
    add_index :groups, :area_id
  end
end
