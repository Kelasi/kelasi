class Backend::PostsController < Backend::BackendController

  before_filter :require_login, only: [:create, :update, :destroy]
  before_filter :current_user_post, only: [:update, :destroy]

  def index
    @timeline_posts = TimelinePost.active_posts.where params.permit(:timeline_id)
  end

  def show
    @timeline_post = TimelinePost.find_by params.permit(:id)
  end

  def create
    inputs = params.permit(:timeline_id, :parent_id, :body).merge(
      user_id: current_user.id, state: TimelinePost::States::ACTIVE)
    @timeline_post = TimelinePost.create! inputs
  end

  def update
    @tp.update! params.permit(:body)
    head :ok
  end

  def destroy
    @tp.update! state: TimelinePost::States::DEACTIVE
    head :ok
  end

  private
    def require_login
      head :unauthorized unless logged_in?
    end

    def current_user_post
      @tp = TimelinePost.find_by params.permit(:id)
      head :unauthorized unless @tp.user == current_user or @tp.timeline.admin? current_user
    end
end
