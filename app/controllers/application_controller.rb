class ApplicationController < ActionController::Base
  include CustomAuth
  protect_from_forgery
  before_filter :ensure_domain
  
  private
  APP_DOMAIN = 'www.prodigitalphotos.com'
  def ensure_domain
    unless request.env['HTTP_HOST'] == APP_DOMAIN || Rails.env.development?
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
end