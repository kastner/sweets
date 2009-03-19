class SessionsController < ApplicationController
  def create
    self.current_project = Project.authenticate(params[:project], params[:password])
    if logged_in?
      save_cookie
      flash[:notice] = "Logged in successfully"
      redirect_back_or_root
    else
      sleep(1)
      redirect_to root_url
    end
  end
  
  def destroy
    drop_cookie
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_root
  end
end
