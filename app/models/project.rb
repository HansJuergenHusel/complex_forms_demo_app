#---
# Excerpted in part from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
class Project < ActiveRecord::Base
  has_many :tasks
  has_many :assignments
  has_many :employees, :through => :assignments
  has_many :categorizations
  has_many :categories, :through => :categorizations

  after_update :save_tasks
  after_update :save_assignments
  after_update :save_categorizations

  validates_presence_of :name
  validates_associated :tasks, :assignments
  
  def new_task_attributes=(task_attributes)
    task_attributes.each do |id,attributes|
      tasks.build(attributes)
    end
  end

  def existing_task_attributes=(task_attributes)
    tasks.reject(&:new_record?).each do |task|
      attributes = task_attributes[task.id.to_s]
      if attributes
        task.attributes = attributes
      else
        task.marked_for_deletion = true
      end
    end
  end

  def new_assignment_attributes=(assignment_attributes)
    assignment_attributes.each do |id,attributes|
      assignments.build(attributes)
    end
  end

  def existing_assignment_attributes=(assignment_attributes)
    assignments.reject(&:new_record?).each do |assignment|
      attributes = assignment_attributes[assignment.id.to_s]
      if attributes
        assignment.attributes = attributes
      else
        assignment.marked_for_deletion = true
      end
    end
  end

  def new_categorization_attributes=(categorization_attributes)
    categorization_attributes.each do |id, attributes|
      categorizations.build(attributes) unless attributes["category_id"] == "0"
    end
  end

  def existing_categorization_attributes=(categorization_attributes)
    categorizations.reject(&:new_record?).each do |categorization|
      attributes = categorization_attributes[categorization.category_id.to_s]
      if attributes
        categorization.attributes = attributes
        categorization.marked_for_deletion = (categorization.category_id == 0)
      end
    end
  end

  private

  # If it has marked_for_deleted == true it will destroy itself after saving
  # This will capture the change, then call destroy
  def save_tasks
    tasks.each do |task|
      task.save
    end
  end

  # If it has marked_for_deleted == true it will destroy itself after saving
  # This will capture the change, then call destroy
  def save_assignments
    assignments.each do |assignment|
      assignment.save
    end
  end

  # If it has marked_for_deleted == true it will destroy itself after saving
  # This will capture the change, then call destroy
  def save_categorizations
    categorizations.each do |categorization|
      categorization.save
    end
  end

end

