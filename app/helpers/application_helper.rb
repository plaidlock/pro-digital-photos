module ApplicationHelper
  def title
    root = 'Pro Digital Photos'
    @page.nil? || @page.title.nil? ? root : "#{@page.title} :: #{root}"
  end

  def keywords
    root = ['pro digital photos']
    return root if @page.nil?

    page_keywords = @page.keywords.split(',').collect{|k| k.strip}.compact unless @page.keywords.nil?
    product_keywords = @page.product.keywords.split(',').collect{|k| k.strip}.compact unless @page.product.nil? || @page.product.keywords.nil?

    keywords = (product_keywords || []) + (page_keywords || []) + root
    return keywords.uniq.join(', ')
  end

  def description
    root = 'Pro Digital Photos is a full-service photo lab in Utah!'
    @page.nil? || @page.description.nil? ? root : @page.description
  end
end