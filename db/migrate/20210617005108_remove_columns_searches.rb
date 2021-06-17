class RemoveColumnsSearches < ActiveRecord::Migration[6.1]
  def change
    remove_column :searches, :height
    remove_column :searches, :mass
  end
end
