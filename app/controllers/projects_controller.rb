class ProjectsController < ApplicationController
  before_filter :project_required, :except => [:home, :new, :create]
  
  def home
    redirect_to project_url if logged_in?
  end
  
  def show
    @project = current_project
    @tweets = current_project.tweets.collect do |tweet|
      tpl = current_project.tweet_template.dup
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
  end

  def new
    @project = Project.new
  end

  def edit
  end
  
  def create
    @project = Project.new(params[:project])
    
    if !passwords_match
      @project.errors.add(:password, "Passwords don't match")
      render :action => "new"
      return
    end
    
    if @project.save
      flash[:notice] = "Project created"
      self.current_project = @project
      save_cookie
      redirect_to project_url
    else
      render :action => "new"
    end
  end
  
  def update
    current_project.update_attributes(params[:project])
    redirect_to edit_project_url
  end
  
private

  def passwords_match
    params[:project][:password] == params[:password_conf]
  end
end
