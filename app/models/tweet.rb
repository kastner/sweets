class Tweet < ActiveRecord::Base
  has_many :tweeps
  has_many :projects, :through => :tweeps
  
  validates_uniqueness_of :twitter_id
  
  named_scope :latest, :order => "tweets.created_at DESC"
  named_scope :from_users, lambda { |users| 
    { :conditions => "from_user_id IN (#{users.join(",")})" }
  }
end
