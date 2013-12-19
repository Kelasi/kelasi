class Backend::ProfilesController < Backend::BackendController

	def show
		profile_name = params[:profile_name]
		@user = User.find_by(profile_name: profile_name)
	end
	
end
