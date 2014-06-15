class Backend::StreamsController < Backend::BackendController

  def index
    unless logged_in?
      render :status => :unauthorized
      return
    end

    @stream_elements = current_user.timelines.flat_map(&:recent_posts)
      .sort_by(&:updated_at).reverse.first 20
  end
end
