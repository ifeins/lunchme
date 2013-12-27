class CreateJoinTableUserTag < ActiveRecord::Migration

  def change
    create_table :users_tags, id: false do |t|
      t.integer :user_id, null: false
      t.integer :tag_id, null: false
    end
  end

end
