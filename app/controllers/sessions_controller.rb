class SessionsController < ApplicationController
  skip_before_filter :require_logged_in, :only => [:new, :create]
  before_filter :redirect_if_logged_in, :only => [:new, :create]
  
  def create
    user = User.authenticate(params[:username], params[:password])
    
    if user.nil?
      redirect_to login_path, :alert => 'Invalid username or password!'
    else
      session[:user_id] = user.id
      redirect_to session[:return_to] || root_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'You were logged out'
  end
end