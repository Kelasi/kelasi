require 'spec_helper'

describe Backend::SearchController do

  describe '#people' do

    let(:user) { FactoryGirl.create :user_with_university }

    before do
      User.tire.index.refresh
    end

    xit "should return user by passing params", :vcr do
      post 'people',
        fname: user.first_name,
        lname: user.last_name,
        university: user.universities.last.name
      expect(response).to be_success
      expect(assigns :users).to include user
    end
  end

  describe '#timelines' do

    let(:timeline) { FactoryGirl.create :timeline,
                       title: 'Some wierd timeline' }

    it "should return timelines that match the query" do
      post 'timelines', q: 'wierd'
      expect(response).to be_success
      expect(assigns :timelines).to include timeline
    end

    it "should not return timelinse that don't match query" do
      post 'timelines', q: 'albala'
      expect(response).to be_success
      expect(assigns :timelines).not_to include timeline
    end
  end
end
