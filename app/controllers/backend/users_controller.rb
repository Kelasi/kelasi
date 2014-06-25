class Backend::UsersController < Backend::BackendController
  def show
    @user = User.find params[:id]
  end

  def create
    keys = %i(
      first_name last_name university
      introducer email password
    )
    keys.each {|k| params.require k }

    p = params.permit(*keys)
    p[:universities] = University.where name: p.delete(:university)
    p[:introducer] = User.find p[:introducer]
    @user = User.create! p
  rescue ActionController::ParameterMissing
    head 406
  end
end
