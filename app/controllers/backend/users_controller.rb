class Backend::UsersController < Backend::BackendController
  def index
    @users = User.all
  end

  def show
    @user = User.new
    # @user = User.find params[:id]
  end

  def update
    render json: {}
  end

  def create
    render json: {}
  end

  def destroy
    render json: {}
  end
end
