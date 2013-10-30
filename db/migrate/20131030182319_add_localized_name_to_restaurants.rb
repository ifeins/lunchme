class AddLocalizedNameToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :localized_name, :string
  end
end
