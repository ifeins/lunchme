class DestroyArea < ActiveRecord::Migration

  def up
    remove_column :restaurants, :area_id
    remove_column :users, :area_id
    drop_table :areas
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
