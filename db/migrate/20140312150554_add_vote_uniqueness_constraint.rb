class AddVoteUniquenessConstraint < ActiveRecord::Migration

  def up
    execute <<-END
      DELETE FROM votes
      WHERE id IN (
        SELECT id FROM (
          SELECT id, row_number()
          OVER (PARTITION BY lunch_id, restaurant_id, user_id ORDER BY id) AS rnum
          FROM votes
        ) t
      WHERE t.rnum > 1);
    END

    add_index :votes, [:lunch_id, :restaurant_id, :user_id], unique: true
  end

  def down
    remove_index :votes, :column => [:lunch_id, :restaurant_id, :user_id]
  end
end
