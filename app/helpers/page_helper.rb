module PageHelper
  def sidebar_navigation(pages)
    # pages is a hash <# Page> => [<# Page>, <# Page>...]
    pages.map do |page, sub_pages|
      string = link_to(page.display_name, slug_path(page), :title => page.display_name, :class => sub_pages.empty? ? nil : 'with-arrow', :'data-path' => slug_path(page))
      string += content_tag(:ul, sidebar_navigation(sub_pages)) unless sub_pages.empty?
      
      content_tag(:li, string, :id => "page_#{page.id}")
    end.join.html_safe
  end
  
  def breadcrumbs(current_page)
    content_tag :div, :id => 'breadcrumbs' do
      (current_page.ancestors << current_page).collect do |page|
        link_to(page.display_name, slug_path(page), :title => page.display_name)
      end.join(' &raquo; ').html_safe
    end
  end
end