class PagesController < ApplicationController
  def index
    # this will be the "home" page eventually
  end
  
  def sort
    page_ids = params[:page]
    page_ids.each_with_index do |page_id, i|
      page = Page.find(page_id)
      page.update_attributes(display_order:i)
    end    
    render :nothing => true
  end
  
  def show
    #@page = Page.find_by_slug!(params[:slug])
    @page = Page.find(params[:id])
    @root_page = @page.root
  end
  
  def new
    @page = Page.new(:parent_id => params[:parent_id])
  end
  
  def create
    @page = Page.new(params[:page])
    
    if @page.save
      redirect_to page_path(@page), :notice => 'Page was successfully created!'
    else
      flash.now[:alert] = @page.errors.full_messages
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    
    if @page.update_attributes(params[:page])
      redirect_to edit_page_path(@page), :notice => 'Page was updated'
    else
      flash.now[:alert] = @page.errors.full_messages.join('<br />').html_safe
      render :action => 'edit'
    end
  end
end