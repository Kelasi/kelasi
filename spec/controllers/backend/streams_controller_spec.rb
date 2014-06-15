require 'spec_helper'

describe Backend::StreamsController do

  describe "'GET' index" do

    context 'not logged in' do

      it "returns http error" do
        get 'index'
        expect(response).not_to be_success
      end
    end

    context 'logged in' do

      before do
        user = FactoryGirl.create :user
        login_user user
        own_timeline = FactoryGirl.create :timeline_with_admin, user: user
        other_timelines = FactoryGirl.create_list :timeline_with_member, 5,
          user: user, role: TimelineUserPermission::Roles::PARTICIPANTS
        @posts = []
        time = Time.now.midnight
        5.times do
          time += 1.minute
          @posts << FactoryGirl.create(
            :timeline_post, timeline: own_timeline, updated_at: time
          )
          other_timelines.each do |timeline|
            time += 1.minute
            @posts << FactoryGirl.create(
              :timeline_post, timeline: timeline, user: user, updated_at: time
            )
          end
        end
      end

      it "should return posts orderly", :vcr do
        get 'index'
        expect(response).to be_success
        expect(assigns :stream_elements).to eq @posts.reverse[0..19]
      end
    end
  end
end
