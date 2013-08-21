class AddQuantityDefaultInTags < ActiveRecord::Migration

  def up
    change_column_default :tags, :quantity, 1
  end

  def down
    change_column_default :tags, :quantity, nil
  end

end
