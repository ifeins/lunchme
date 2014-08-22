class RemoveSurveys < ActiveRecord::Migration
  def up
    drop_table :surveys
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
