class AddLogoUrlToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :logo_url, :string
  end
end
