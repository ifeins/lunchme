class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :status
      t.references :user
      t.references :lunch

      t.timestamps
    end
    add_index :surveys, :user_id
    add_index :surveys, :lunch_id
  end
end
