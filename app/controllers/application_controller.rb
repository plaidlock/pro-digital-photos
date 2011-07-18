class ApplicationController < ActionController::Base
  include CustomAuth
  protect_from_forgery
end