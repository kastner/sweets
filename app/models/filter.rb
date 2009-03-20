class Filter < ActiveRecord::Base
  belongs_to :project
  
  validates_presence_of :project_id
  validates_uniqueness_of :from_user, :scope => :project_id, :case_sensitive => false
end
