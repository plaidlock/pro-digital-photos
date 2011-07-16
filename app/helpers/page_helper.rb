module PageHelper
  def sidebar_navigation(pages)
    pages.map do |page, sub_pages|
      content_tag :li do
        link_to(page.title, page_path(page)) + content_tag(:ul, sidebar_navigation(sub_pages))
      end
    end.join.html_safe
  end
end