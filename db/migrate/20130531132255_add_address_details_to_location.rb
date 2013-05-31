class AddAddressDetailsToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :street, :string
    add_column :locations, :city, :string
    remove_columns :locations, :radius, :name
  end

  def down
    remove_columns :locations, :street, :city
    add_column :locations, :radius, :float
    add_column :locations, :name, :string
  end
end
