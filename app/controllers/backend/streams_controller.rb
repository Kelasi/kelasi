class Backend::StreamsController < Backend::BackendController

  def index
    page = (params[:page] || 1).to_i
    @stream_elements = Timeline.recent_timelines.page page
  end
end
