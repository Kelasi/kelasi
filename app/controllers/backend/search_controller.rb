class Backend::SearchController < Backend::BackendController

   def search
     fname = params[:fname]
     lname = params[:lname]
     uniname = params[:uniname]
     @users = User.search_user first_name: fname, last_name: lname, university: uniname
   end
end
