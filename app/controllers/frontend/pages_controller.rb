class Frontend::PagesController < Frontend::FrontendController
  def page
    page = params[:page]
    page ||= ''
    page = File.join 'frontend/pages/', page
    page_index = File.join page, 'index.haml'
    if File.exists? File.join Rails.root, 'app/views', page_index
      page = page_index
    else
      page += '.haml'
    end
    render page
  end
end
