#---
# Excerpted in part from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
class Project < ActiveRecord::Base
  has_many :tasks, :single_save => true
  has_many :assignments, :single_save => true
  has_many :employees, :through => :assignments
  has_many :categorizations
  has_many :categories, :through => :categorizations, :single_save => true
  has_one :project_detail, :single_save => true
  has_and_belongs_to_many :tags

  validates_presence_of :name
  validates_associated :tasks, :assignments

  class << self
    # If it's invalid return false
    # If it's valid and saves, return true
    # If there is an error in the transaction, re-raise the error
    def save(project,project_attributes = nil)
      project.attributes = project_attributes unless project_attributes.nil?
      updated = false
      Project.transaction do
        updated = project.save
      end
      updated
    rescue Exception => e
      throw e
    end
  end
  
  def code_string=(codestring)
    code_hash = {}
    codestring.split(",").map(&:strip).each_with_index do |name, index|
      code_hash[index] = {:name => name}
    end
    code_attributes = code_hash
  end

end