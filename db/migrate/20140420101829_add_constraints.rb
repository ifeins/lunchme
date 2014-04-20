class AddConstraints < ActiveRecord::Migration

  def up
    change_column :accounts, :provider, :string, null: false
    change_column :accounts, :uid, :string, null: false
    add_index :accounts, [:provider, :uid], unique: true

    change_column :lunches, :date, :date, null: false
    add_index :lunches, :date, unique: true

    change_column :offices, :name, :string, null: false
    add_index :offices, :name, unique: true

    change_column :payment_methods, :name, :string, null: false
    add_index :payment_methods, :name, unique: true

    change_column :restaurants, :name, :string, null: false
    add_index :restaurants, :name, unique: true

    change_column :tag_definitions, :name, :string, null: false
    add_index :tag_definitions, :name, unique: true

    add_index :users, :email, unique: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
