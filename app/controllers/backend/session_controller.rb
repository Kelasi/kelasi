class Backend::SessionController < Backend::BackendController
  def show
    @response = {user: current_user, logged_in: logged_in?}
  end

  def create
    user = login params[:email], params[:password]
    head (user.present? ? :ok : :unauthorized)
  end

  def destroy
    logout
    render json: {}
  end
end
