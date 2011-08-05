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
        begin
          link_to(page.display_name, slug_path(page), :title => page.display_name)
        rescue
          '[Here]'
        end
      end.join(' &raquo; ').html_safe
    end
  end

  def all_paths(current_page = nil)
    return Page.roots.collect{|p| all_paths(p)} if current_page.nil?
    current_page.children.collect{|p| all_paths(p)}
  end

  def link_to_product_button(product, html = {})
    return link_to "Order #{product.name} Now", product.dakis_url, html.merge({:class => 'button', :target => :top}) if dakis_supported_browser?
    link_to "Order #{product.name} Now", nil, html.merge({:class => 'button', :onclick => 'javascript:alert("You are not using a supported browser. Our photo ordering system does not work with Internet Explorer or Opera. Please download Chrome, Safari, or Firefox to use our online ordering system.")'})
  end

  private
  def dakis_supported_browser?
    return !request.user_agent.match(/(gecko|khtml|webkit)/i).nil?
  end
end