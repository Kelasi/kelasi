class Backend::SearchController < Backend::BackendController

   def people
     fname = params[:fname]
     lname = params[:lname]
     uniname = params[:uniname]
     @users = User.search_user first_name: fname, last_name: lname, university: uniname
   end

   def timelines
     title = params[:q]
     if title
       @timelines = Timeline.where "title LIKE ?", "%#{title}%"
     else
       @timelines = []
     end
   end
end
