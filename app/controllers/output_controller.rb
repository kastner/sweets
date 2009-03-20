class OutputController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @tweets = @project.tweets.collect do |tweet|
      tpl = @project.tweet_template.dup
      tpl.gsub!("%tweet.text%", tweet.text.to_s)
      tpl.gsub!("%tweet.to_user_id%", tweet.to_user_id.to_s)
      tpl.gsub!("%tweet.to_user%", tweet.to_user.to_s)
      tpl.gsub!("%tweet.from_user%", tweet.from_user.to_s)
      tpl.gsub!("%tweet.twitter_id%", tweet.twitter_id.to_s)
      tpl.gsub!("%tweet.from_user_id%", tweet.from_user_id.to_s)
      tpl.gsub!("%tweet.iso_language_code%", tweet.iso_language_code.to_s)
      tpl.gsub!("%tweet.source%", tweet.source.to_s)
      tpl.gsub!("%tweet.profile_image_url%", tweet.profile_image_url.to_s)
      tpl.gsub!("%tweet.created_at%", tweet.created_at.to_s)
      tpl.gsub!("%tweet.updated_at%", tweet.updated_at.to_s)
      tpl
    end.join("\n")
    
    render :template => "projects/show.out.erb"
  end
end
