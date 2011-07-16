module PageHelper
  def navigation(pages)
    pages.map do |page|
      link_to(page.title, page_path(page)) + content_tag(:div, navigation(page.children), :class => 'navigation')
    end.join.html_safe
  end
end