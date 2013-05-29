class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :uid
      t.string :provider
      t.references :user

      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
