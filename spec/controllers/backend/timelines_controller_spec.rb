require 'spec_helper'

describe Backend::TimelinesController do

  describe "'GET' index" do
    it "returns http success" do
      timeline = FactoryGirl.create :timeline
      get 'index'
      expect(assigns(:timelines)).to eq [timeline]
      expect(response).to be_success
    end
  end

  describe "'GET' show" do
    it "returns http success" do
      @timeline = FactoryGirl.create :timeline
      get 'show', id: @timeline.id
      expect(response).to be_success
    end
  end

  describe "'POST' create" do
    it "should create a new timeline with valid attributes" do
      @user = FactoryGirl.create :user
      login_user( user= @user )
      expect{
        post 'create', title: 'MyTimeline'
      }.to change(Timeline, :count).by(1)
    end

    it "should unable to save a timeline when a user is not logged in" do
      logout_user
      expect{
        post 'create', title: 'MyTimeline'
      }.not_to change Timeline, :count
    end
  end

  describe "'PUT' update" do

    before :each do
      @tup      = FactoryGirl.create :timeline_user_permission
      @timeline = @tup.timeline
      @admin    = @tup.user
    end

    it "returns http success" do
      login_user( user= @admin )
      put 'update', id: @timeline.id
      expect(assigns(:timeline)).to eq @timeline
      expect(response).to be_success
    end

    it "should update timeline title with valid attributes" do
      login_user( user= @admin )
      put 'update', id: @timeline.id, title: "NewTitle"
      expect(@timeline.reload.title).to eq "NewTitle"
    end

    it "should unable to update timeline when user is not timeline admin" do
      @user = FactoryGirl.create :user
      login_user( user= @user )
      put 'update', id: @timeline.id, title: "NewTitle"
      expect(response).not_to be_success
    end

    it "should unable to update timeline when user is not logged in" do
      logout_user
      put 'update', id: @timeline.id, title: "NewTitle"
      expect(response).not_to be_success
    end
  end

  describe "'DELETE' destroy" do

    before :each do
      @tup      = FactoryGirl.create :timeline_user_permission
      @timeline = @tup.timeline
      @admin    = @tup.user
    end

    it "returns http success" do
      login_user( user= @admin )
      delete 'destroy', id: @timeline.id
      response.should be_success
    end

    it "should delete the timeline when its admin asks for" do
      login_user( user= @admin )
      expect{
        delete 'destroy', id: @timeline.id
      }.to change(Timeline, :count).by(-1)
    end

    it "should unable to delete the timeline when a non-admin user asks for" do
      @user = FactoryGirl.create :user
      login_user( user= @user )
      expect{
        delete 'destroy', id: @timeline.id
      }.not_to change Timeline, :count
    end

    it "should unable to delete the timeline when user is not login" do
      logout_user
      expect{
        delete 'destroy', id: @timeline.id
      }.not_to change Timeline, :count
    end
  end
end
