class Assignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  validates_presence_of :title
end
