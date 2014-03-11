class Backend::SessionController < Backend::BackendController
  def show
    if logged_in?
      @user = current_user
    else
      head :unauthorized
    end
  end

  def create
    user = login params[:email], params[:password]
    head (user.present? ? :ok : :unauthorized)
  end

  def destroy
    logout
    head :ok
  end
end
