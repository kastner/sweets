class Tweep < ActiveRecord::Base
  belongs_to :project
  belongs_to :tweet
  
  validates_uniqueness_of :tweet_id, :scope => :project_id
end
