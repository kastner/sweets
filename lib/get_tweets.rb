require 'open-uri'
require 'json'
require 'uri'

module TwitterSearch
  extend self

  def self.fetch(terms, last_id)
    string = json_string(terms, last_id)
    JSON.parse(string)
  end
  
  def self.json_string(terms, last_id)
    puts url % [terms, last_id]
    open(url % [terms, last_id]).read
  end
  
  def self.url
    "http://search.twitter.com/search.json?rpp=100&q=%s&since_id=%s"
  end
end

Project.all.each do |project|
  last_id = (!project.tweets.empty? && project.tweets.first.twitter_id) || 0
  results = TwitterSearch.fetch(URI.escape(project.terms), last_id)
  results["results"].each do |tweet|
    tweet["twitter_id"] = tweet.delete("id")
    t = Tweet.find_or_create_by_twitter_id(tweet)
    project.tweets << t unless project.tweets.include?(t)
  end
  project.apply_filters
end