class FiltersController < ApplicationController
  before_filter :project_required
  
  def index
  end

  def show
    @filter = current_project.filters.find(params[:id])
  end

  def new
    @filter = current_project.filters.build
  end

  def edit
    @filter = current_project.filters.find(params[:id])
  end
  
  def create
    @filter = current_project.filters.build(params[:filter])
    if @filter.save
      current_project.apply_filters
      redirect_to project_filters_url
    else
      render :action => "new"
    end
  end
  
  def update
  end
  
  def destroy
    @filter = current_project.filters.find(params[:id])
    @filter.delete
    redirect_to project_filters_url
  end
end
