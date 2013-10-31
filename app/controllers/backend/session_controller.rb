class Backend::SessionController < Backend::BackendController
  def show
    @response = {user: current_user, logged_in: logged_in?}
  end

  def create
    @user = login params[:email], params[:password]
    render json: {}, status: 403 unless @user
    render json: {} if @user
  end

  def destroy
    logout
    render json: {}
  end
end
