class ApplicationController < ActionController::Base
  include CustomAuth
  protect_from_forgery
  #before_filter :ensure_domain
  layout :process_layout

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_path, :notice => 'You must be logged in to perform that action!'
  end

  private
  APP_DOMAIN = 'www.prodigitalphotos.com'
  def ensure_domain
    unless request.env['HTTP_HOST'] == APP_DOMAIN || Rails.env.development?
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end

  def process_layout
    request.xhr? ? nil : 'application'
  end
end