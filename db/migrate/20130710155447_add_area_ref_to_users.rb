class AddAreaRefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :area_id, :integer
    add_index :users, :area_id
  end
end
