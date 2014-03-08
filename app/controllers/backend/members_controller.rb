class Backend::MembersController < Backend::BackendController
  def index
    @members = Timeline.find(params[:timeline_id]).users
  end

  def show
    @member = TimelineUserPermission.find(params[:id]).user
  end

  def destroy
    tup = TimelineUserPermission.find params[:id]
    if tup.timeline.admin? current_user or tup.user == current_user
      tup.destroy
      head :ok
    else
      head :unauthorized
    end
  end

  def update
    tup = TimelineUserPermission.find params[:id]
    if tup.timeline.admin? current_user
      tup.update! params.permit(:role)
      head :ok
    else
      head :unauthorized
    end
  end

  def create
    if logged_in?
      timeline = Timeline.find params[:timeline_id]
      @membership = timeline.add_member current_user
    else
      head :unauthorized
    end
  end
end
