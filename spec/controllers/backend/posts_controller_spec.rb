require 'spec_helper'

describe Backend::PostsController do

  describe "'GET' show" do
    it "returns http success and returns the post", :vcr do
      tp = FactoryGirl.create :timeline_post
      get 'show', id: tp.id
      expect(assigns(:timeline_post)).to eq tp
      expect(response).to be_success
    end
  end

  describe "'POST' create" do
    it "should save a timeline post with valid attributes", :vcr do
      user = FactoryGirl.create :user
      login_user( user= user )
      expect{
        post 'create', timeline_id: 1, parent_id: 0, body: "MyPost"
      }.to change(TimelinePost, :count).by(1)
    end

    it "should unable to create a new timeline when a user is not logged in", :vcr do
      logout_user
      expect{
        post 'create', timeline_id: 1, parent_id: 0, body: "MyPost"
      }.not_to change TimelinePost, :count
    end
  end

  describe "'PUT' update" do

    let(:tp) { FactoryGirl.create :timeline_post }

    it "returns http success", :vcr do
      login_user ( user= tp.user)
      put 'update', id: tp.id
      expect(response).to be_success
    end

    it "should update timeline post body with valid attributes", :vcr do
      login_user ( user= tp.user )
      put 'update', id: tp.id, body: "UpdatedBody"
      expect(tp.reload.body).to eq "UpdatedBody"
    end

    it "should unable to update timeline post when user is not the post owner", :vcr do
      random_user = FactoryGirl.create :user
      login_user ( user= random_user )
      put 'update', id: tp.id, body: "UpdatedBody"
      expect(response).not_to be_success
    end

    it "should unable to update timeline post when user is not logged in", :vcr do
      logout_user
      put 'update', id: tp.id, body: "UpdatedBody"
      expect(response).not_to be_success
    end
  end

  describe "'DELETE' destroy" do

    let(:tp) { FactoryGirl.create :timeline_post }

    it "returns http success", :vcr do
      login_user ( user= tp.user)
      delete 'destroy', id: tp.id
      expect(response).to be_success
    end

    it "should delete the timeline post when its owner asks for", :vcr do
      login_user ( user= tp.user )
      delete 'destroy', id: tp.id
      expect(tp.reload.state).to eq TimelinePost::States::DEACTIVE
    end

    it "does not delete the timeline post when a random user send a delete request", :vcr do
      random_user = FactoryGirl.create :user
      login_user ( user= random_user )
      delete 'destroy', id: tp.id
      expect(tp.reload.state).to eq TimelinePost::States::ACTIVE
    end

    it "should unable to delete the timeline post when user is not logged in", :vcr do
      logout_user
      delete 'destroy', id: tp.id
      expect(tp.reload.state).to eq TimelinePost::States::ACTIVE
    end

    it "should delete the post when the admin of a timeline send a delete request", :vcr do
      tup   = FactoryGirl.create :timeline_user_permission, role: TimelineUserPermission::Roles::ADMIN
      tp    = tup.timeline.timeline_posts.create! user: FactoryGirl.create(:user), body: "MyString"
      login_user ( user= tup.user )
      delete 'destroy', id: tp.id
      expect(tp.reload.state).to eq TimelinePost::States::DEACTIVE
    end
  end
end
