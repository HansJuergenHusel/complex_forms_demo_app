class CreateProjectDetails < ActiveRecord::Migration
  def self.up
    create_table :project_details do |t|
      t.integer :project_id
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :project_details
  end
end
