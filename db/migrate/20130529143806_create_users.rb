class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :avatar_url
      t.references :group

      t.timestamps
    end
    add_index :users, :group_id
  end
end
