class CreateCodesProjects < ActiveRecord::Migration
  def self.up
    create_table :codes_projects do |t|
      t.integer :code_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :codes_projects
  end
end
