require 'spec_helper'

describe Backend::StreamsController do

  describe "'GET' index" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    it "should returns older stream elements (timelines) based on page number and ordered by created_at" do
      timelines = FactoryGirl.create_list(:timeline, 5)
      get 'index', page: 2
      expect(assigns(:stream_elements)).to eq timelines.reverse[2...4]
    end
  end
end
