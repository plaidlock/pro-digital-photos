module CustomAuth
  def self.included(controller)
    controller.send :helper_method, :current_user, :logged_in?
  end
  
  # gets the current user via caching. Assumes you have a `User` model and that the
  # primary key is `id`. To force another call to the database, pass force_session_reload=true
  # in the params (method doesn't matter). You will need to set the `session[:user_id]` key in
  # your login method (see sample) or this method will return nil.
  def current_user
    #@current_user ||= Rails.cache.fetch("users/#{session[:user_id]}", :force => (params[:force_session_reload] != nil)) { User.find_by_id(session[:user_id]) }
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def require_logged_in
    unless logged_in?
      session[:return_to] = request.url
      redirect_to login_url, :alert => 'You must be logged in to perform that action'
    end
  end
  
  def redirect_if_logged_in
    redirect_to :back || root_path, :notice => 'You are already logged in' if logged_in?
  end
end