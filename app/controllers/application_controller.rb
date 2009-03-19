require 'digest/sha1'

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  def logged_in?
    current_project != nil
  end
  
  def current_project
    @project ||= project_from_cookie
  end
  
  def current_project=(project)
    @project = project
  end
  
  def project_required
    current_project || access_denied
  end
  
  def access_denied
    store_location
    flash[:error] = "You must login to a project before you can do that."
    redirect_to root_url
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def project_from_cookie
    project = Project.get_from_cookie(cookies[:project])
    self.current_project = project if project
  end
  
  def redirect_back_or_root
    redirect_to(session[:return_to] || root_url)
    session[:return_to] = nil
  end
end
