class SessionsController < ApplicationController
  def create
    self.current_project = Project.authenticate(params[:project], params[:password])
    if logged_in?
      cookies[:project] = { 
        :value => current_project.cookie, 
        :expires => Time.now + 3.years
      }
      flash[:notice] = "Logged in successfully"
      redirect_back_or_root
    else
      redirect_to root_url
    end
  end
  
  def destroy
    cookies.delete :project
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_root
  end
end
