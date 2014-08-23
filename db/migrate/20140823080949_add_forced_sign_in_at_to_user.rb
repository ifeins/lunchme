class AddForcedSignInAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :forced_signed_in_at, :datetime
  end
end
