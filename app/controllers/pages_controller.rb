class PagesController < ApplicationController
  def index
    # this will be the "home" page eventually
  end
  
  def show
    @page = Page.find_by_slug!(params[:slug])
    @root_page = @page.root
  end
  
  def new
    @page = Page.new(:parent_id => params[:parent_id])
  end
  
  def create
    @page = Page.new(params[:page])
    
    if @page.save
      redirect_to :back, :notice => 'Page was successfully created!'
    else
      flash.now[:alert] = @page.errors.full_messages
      render :action => 'new'
    end
  end
end