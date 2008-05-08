class CreateProjectsTags < ActiveRecord::Migration
  def self.up
    create_table :projects_tags do |t|
      t.integer :project_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects_tags
  end
end
