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
    begin
      keys = %i(
        first_name last_name university
        introducer email password
      )
      keys.each {|k| params.require k }

      p = params.permit(*keys)
      p[:universities] = [
        University.find_by(name: p.delete(:university))
      ]
      p[:introducer] = User.find p[:introducer]
      @user = User.create! p
    rescue ActionController::ParameterMissing
      head 406
    end
  end

  def destroy
    render json: {}
  end
end
