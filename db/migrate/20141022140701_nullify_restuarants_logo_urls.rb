class NullifyRestuarantsLogoUrls < ActiveRecord::Migration
  def up
    execute 'UPDATE restaurants SET logo=NULL'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
