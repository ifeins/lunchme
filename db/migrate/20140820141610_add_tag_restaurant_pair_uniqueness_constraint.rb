class AddTagRestaurantPairUniquenessConstraint < ActiveRecord::Migration
  def up
    execute <<-END
      DELETE FROM tags
      WHERE id IN (
        SELECT id FROM (
          SELECT id, row_number()
          OVER (PARTITION BY tag_definition_id, restaurant_id ORDER BY id) AS rnum
          FROM tags
        ) t
      WHERE t.rnum > 1);
    END

    add_index :tags, [:tag_definition_id, :restaurant_id], unique: true
  end

  def down
    remove_index :tags, column: [:tag_definition_id, :restaurant_id]
  end
end
