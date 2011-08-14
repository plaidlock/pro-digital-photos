class PagesController < ApplicationController
  load_and_authorize_resource :page, :except => [:show]

  def sort
    page_ids = params[:page]
    page_ids.each_with_index do |page_id, i|
      page = Page.find(page_id)
      page.update_attributes(display_order:i)
    end
    render :nothing => true
  end

  def show
    @page = Page.active.find_by_slug!(params[:id])
    @root_page = @page.root
    @product_pages = @page.children
  end

  def hidden
    @pages = Page.inactive.order('pages.slug')
  end

  def new
    @page.parent_id = params[:parent_id]
    @page.build_product
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to slug_path(@page), :notice => 'Page was successfully created!'
    else
      flash.now[:alert] = @page.errors.full_messages
      render :action => 'new'
    end
  end

  def edit
    @page.product || @page.build_product
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to edit_page_path(@page.id), :notice => 'Page was updated'
    else
      flash.now[:alert] = @page.errors.full_messages.join('<br />').html_safe
      render :action => 'edit'
    end
  end

  def restore
    if @page.update_attributes(:is_active => true)
      redirect_to hidden_pages_path, :notice => 'Page was activated!'
    else
      flash.now[:alert] = @page.errors.full_messages.join('<br />').html_safe
      render :action => 'hidden'
    end
  end

  def destroy
    if @page.destroy
      redirect_to pages_path, :notice => 'Page was destroyed!'
    else
      flash.now[:error] = @page.errors.full_messages.join('<br />').html_safe
      render :action => 'edit'
    end
  end
end