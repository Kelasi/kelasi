require 'spec_helper'

describe Backend::StreamsController do

  describe "'GET' index" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    it "should assigns and returns timelines" do
      t = FactoryGirl.create :timeline
      get 'index'
      expect(assigns(:timelines)).to eq [t]
    end

    it "should populate timelines based on created_at and descending" do
      t1 = FactoryGirl.create :timeline, created_at: Date.yesterday
      t2 = FactoryGirl.create :timeline, created_at: Date.today
      get 'index'
      expect(assigns(:timelines)).to eq [t2, t1]
    end

    context 'pagination' do
      it "should get a value as paginate page" do
        Timeline.should_receive(:stream).with({page: 2})
        get 'index', page: 2
      end

      it "should not be success if the page that client requested does not exist" do
        non_exist_page = Timeline.count / Timeline::PAGINATION_LIMIT + 2
        get 'index', page: non_exist_page
        expect(response).not_to be_success
      end

      it "should not be success for invalid page number" do
        invalid_page = -1
        get 'index', page: invalid_page
        expect(response).not_to be_success
      end

      it "should return timelines based on the page number" do
        limit = Timeline::PAGINATION_LIMIT
        ( limit - Timeline.count % limit + 1 ).times do
          FactoryGirl.create :timeline
        end
        get 'index', page: 2
        expect(assigns(:timelines).size).to eq 1
      end
    end
  end
end
