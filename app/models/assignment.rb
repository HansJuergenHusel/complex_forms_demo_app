class Assignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  validates_presence_of :title
  validates_presence_of :employee_id
end
