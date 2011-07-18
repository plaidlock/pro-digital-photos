class SitemapsController < ApplicationController
  respond_to :xml
  
  def index
    @pages = Page.roots
  end
  
  def show
    @root = Page.find_by_slug(params[:id])
    @pages = @root.descendants
  end
end