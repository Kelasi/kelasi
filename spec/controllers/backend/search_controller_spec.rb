require 'spec_helper'

describe Backend::SearchController do

  describe :search do

    let(:user) { FactoryGirl.create :user_with_university }

    before do
      User.tire.index.refresh
    end

    it "should return user by passing params" do
      post 'search',
        fname: user.first_name,
        lname: user.last_name,
        university: user.universities.last.name
      expect(response).to be_success
      expect(assigns :users).to include user
    end
  end
end
