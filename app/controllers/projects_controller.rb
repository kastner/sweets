class ProjectsController < ApplicationController
  before_filter :project_required, :except => [:home, :new, :create]
  
  def home
  end
  
  def show
    @project = current_project
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
  end
  
private

  def passwords_match
    params[:project][:password] == params[:password_conf]
  end
end
