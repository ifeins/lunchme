class AddOfficeRefToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :office, index: true
    end
  end
end
