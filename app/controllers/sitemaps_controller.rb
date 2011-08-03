class SitemapsController < ApplicationController
  respond_to :xml

  def index
    @pages = Page.roots.active
  end

  def show
    @root = Page.active.find_by_slug!(params[:id])
    @pages = @root.descendants.active << @root
  end
end