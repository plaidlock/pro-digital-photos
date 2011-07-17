module PageHelper
  def sidebar_navigation(pages)
    # pages is a hash <# Page> => [<# Page>, <# Page>...]
    pages.map do |page, sub_pages|
      string = link_to(page.title, page_path(page), :class => sub_pages.empty? ? nil : 'with-arrow', :'data-path' => page_path(page))
      string += content_tag(:ul, sidebar_navigation(sub_pages)) unless sub_pages.empty?
      
      content_tag(:li, string)
    end.join.html_safe
  end
end