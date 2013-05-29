class CreateLunches < ActiveRecord::Migration
  def change
    create_table :lunches do |t|
      t.date :date
      t.references :group

      t.timestamps
    end
    add_index :lunches, :group_id
  end
end
