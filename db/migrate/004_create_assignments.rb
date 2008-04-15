class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :employee_id
      t.integer :project_id
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
