class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :quantity
      t.references :tag_definition
      t.references :restaurant

      t.timestamps
    end
    add_index :tags, :tag_definition_id
    add_index :tags, :restaurant_id
  end
end
