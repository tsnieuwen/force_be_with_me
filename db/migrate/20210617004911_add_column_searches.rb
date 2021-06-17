class AddColumnSearches < ActiveRecord::Migration[6.1]
  def change
    add_column :searches, :taller_than, :integer
    add_column :searches, :shorter_than, :integer
    add_column :searches, :heavier_than, :integer
    add_column :searches, :lighter_than, :integer
  end
end
