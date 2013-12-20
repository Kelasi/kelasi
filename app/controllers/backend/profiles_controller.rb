class Backend::ProfilesController < Backend::BackendController

	def show
		@user = User.find_by params.permit :profile_name
	end
end
