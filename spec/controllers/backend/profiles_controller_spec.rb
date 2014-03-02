require 'spec_helper'

describe Backend::ProfilesController do
	subject { FactoryGirl.create :user }

	describe "GET 'show'" do

	    it "returns http success", :vcr do
	      get 'show', profile_name: subject.profile_name
	      expect(response).to be_success
	    end

	    it "should returns user's informations", :vcr do
	    	get 'show', profile_name: subject.profile_name
	    	expect(assigns(:user)).to eq subject
	    end
	end

end
