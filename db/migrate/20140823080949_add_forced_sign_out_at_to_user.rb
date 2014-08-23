class AddForcedSignOutAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :forced_sign_out_at, :datetime
  end
end
