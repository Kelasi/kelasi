class Frontend::PagesController < Frontend::FrontendController
  def page
    page = params[:page]
    page ||= 'index'
    render "frontend/pages/#{page}.haml"
  end
end
