class Backend::SessionController < Backend::BackendController
  def show
    @user = current_user
  end

  def create
    @user = login params[:email], params[:password]
    render json: {}
  end

  def destroy
    logout
    render json: {}
  end
end
