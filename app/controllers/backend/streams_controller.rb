class Backend::StreamsController < Backend::BackendController
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    head :not_found if (page - 1) * Timeline::PAGINATION_LIMIT > Timeline.count or page < 1
    @timelines = Timeline.stream page: page
  end
end
