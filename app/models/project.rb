class Project < ActiveRecord::Base
  has_many :filters
  
  # def filter_tweets
  #   move through the ptweets and disconnect any bad ones
  # end
end
