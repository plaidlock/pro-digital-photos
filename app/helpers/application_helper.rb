module ApplicationHelper
  def title
    root = 'Pro Digital Photos'
    @page.nil? ? root : "#{@page.title} :: #{root}"
  end
  
  def keywords
    root = 'pro digital photos'
    @page.nil? ? root : "#{@page.keywords}, #{root}"
  end
  
  def description
    root = 'Pro Digital Photos is a full-service photo lab in Utah'
    @page.nil? ? root : @page.description
  end
end