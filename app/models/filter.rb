class Filter < ActiveRecord::Base
  belongs_to :project
  
  validates_presence_of :project_id
  validates_uniqueness_of :from_user_id, :scope => :project_id
end
