class ProjectsController < ApplicationController
  before_filter :project_required, :except => [:home, :new, :create]
  
  def home
  end
  
  def show
  end

  def new
  end

  def edit
  end
end
