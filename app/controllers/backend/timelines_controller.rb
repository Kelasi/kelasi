class Backend::TimelinesController < Backend::BackendController

  before_filter :require_login, only: [:create, :update, :destroy]
  before_filter :current_user_timeline, only: [:update, :destroy]

  def index
    @timelines = User.find(params[:user_id]).timelines
  end

  def show
    @timeline = Timeline.find params[:id]
  end

  def create
    @timeline = Timeline.create! admin: current_user, title: params[:title]
  end

  def update
    @timeline.update! params.permit(:title)
    head :ok
  end

  def destroy
    @timeline.destroy
    head :ok
  end

  private
    def require_login
      head :unauthorized unless logged_in?
    end

    def current_user_timeline
      @timeline = current_user.timelines.find_by params.permit(:id)
      head :unauthorized if @timeline.nil?
    end
end
