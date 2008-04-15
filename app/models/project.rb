class Project < ActiveRecord::Base
  has_many :tasks
  has_many :assignments
  has_many :employees, :through => :assignments
  has_many :categorizations
  has_many :categories, :through => :categorizations

  after_update :save_tasks
  after_update :save_assignments
  after_update :save_categorizations

  def new_task_attributes=(task_attributes) 
    return if task_attributes.nil?
    task_attributes.each do |attributes| 
      tasks.build(attributes) 
    end 
  end 

  def existing_task_attributes=(task_attributes) 
    return if task_attributes.nil?
    tasks.reject(&:new_record?).each do |task| 
      attributes = task_attributes[task.id.to_s] 
      if attributes 
        task.attributes = attributes 
      else 
        tasks.delete(task) 
      end 
    end 
  end

  def new_assignment_attributes=(assignment_attributes) 
    return if assignment_attributes.nil?
    assignment_attributes.each do |attributes| 
      assignments.build(attributes) 
    end 
  end 

  def existing_assignment_attributes=(assignment_attributes) 
    return if assignment_attributes.nil?
    assignments.reject(&:new_record?).each do |assignment| 
      attributes = assignment_attributes[assignment.id.to_s] 
      if attributes 
        assignment.attributes = attributes 
      else 
        assignments.delete(assignment) 
      end 
    end 
  end

  def new_categorization_attributes=(categorization_attributes) 
    return if categorization_attributes.nil?
    categorization_attributes.each do |attributes| 
      categorizations.build(attributes) 
    end 
  end 

  def existing_categorization_attributes=(categorization_attributes) 
    return if categorization_attributes.nil?
    categorizations.reject(&:new_record?).each do |categorization| 
      attributes = categorization_attributes[categorization.id.to_s] 
      if attributes 
        categorization.attributes = attributes 
      else 
        categorizations.delete(categorization) 
      end 
    end 
  end
  
  private

  def save_tasks 
    tasks.each do |task| 
      task.save
    end 
  end 

  def save_assignments 
    assignments.each do |assignment| 
      assignment.save
    end 
  end 

  def save_categorizations 
    categorizations.each do |categorization| 
      categorization.save
    end 
  end 

end
