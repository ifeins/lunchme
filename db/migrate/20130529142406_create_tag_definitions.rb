class CreateTagDefinitions < ActiveRecord::Migration
  def change
    create_table :tag_definitions do |t|
      t.string :name

      t.timestamps
    end
  end
end
