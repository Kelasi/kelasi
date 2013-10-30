class Backend::UsersController < Backend::BackendController
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def update
  end

  def create
  end

  def destroy
  end
end
