class AddColumnSortingOrderToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :sorting_order, :integer
  end

  def self.down
    remove_column :tasks, :sorting_order
  end
end