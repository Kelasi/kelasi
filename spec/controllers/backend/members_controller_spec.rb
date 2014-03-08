require 'spec_helper'

describe Backend::MembersController do

  let(:membership) { FactoryGirl.create :timeline_user_permission }

  describe "GET 'index'" do
    let(:timeline) { FactoryGirl.create :timeline_with_some_members }

    it "returns http success", :vcr do
      get 'index', timeline_id: timeline.id
      response.should be_success
    end

    it "should return all members", :vcr do
      get 'index', timeline_id: timeline.id
      expect(assigns :members).to eq timeline.users
    end
  end

  describe "GET 'show'" do
    it "returns http success", :vcr do
      get 'show', id: membership.id
      response.should be_success
    end

    it "should return the correct user", :vcr do
      get 'show', id: membership.id
      expect(assigns :member).to eq membership.user
    end
  end

  describe "DELETE 'destroy'" do

    context "logged in as admin" do

      before do
        timeline_admin = FactoryGirl.create :user
        FactoryGirl.create :timeline_user_permission,
          timeline: membership.timeline,
          user: timeline_admin,
          role: TimelineUserPermission::Roles::ADMIN
        login_user timeline_admin
      end

      it "should delete the membership from database", :vcr do
        id = membership.id
        expect{
          delete 'destroy', id: id
        }.to change(TimelineUserPermission, :count).by -1
        expect(response).to be_success
      end
    end

    context "logged in as the user" do

      before do
        membership.update role: TimelineUserPermission::Roles::PARTICIPANTS
        login_user membership.user
      end

      it "should delete the membership from database", :vcr do
        id = membership.id
        expect{
          delete 'destroy', id: id
        }.to change(TimelineUserPermission, :count).by -1
        expect(response).to be_success
      end
    end

    context "logged in as different user" do

      before { login_user FactoryGirl.create :user }

      it "should refuse deleting", :vcr do
        id = membership.id
        expect{
          delete 'destroy', id: id
        }.not_to change(TimelineUserPermission, :count)
        expect(response).not_to be_success
      end
    end

    context "not logged in" do

      before { logout_user }

      it "should return error and don't delete user", :vcr do
        id = membership.id
        expect{
          delete 'destroy', id: id
        }.not_to change(TimelineUserPermission, :count)
        expect(response).not_to be_success
      end
    end
  end

  describe "PUT 'update'" do

    context "logged in as admin" do

      before do
        admin = FactoryGirl.create :user
        FactoryGirl.create :timeline_user_permission,
          timeline: membership.timeline,
          user: admin,
          role: TimelineUserPermission::Roles::ADMIN
        login_user admin
      end

      it "should update the membership and return success", :vcr do
        membership.update! role: TimelineUserPermission::Roles::PARTICIPANTS
        put 'update', id: membership.id,
          role: TimelineUserPermission::Roles::ADMIN

        membership.reload
        expect(membership.role).to eq TimelineUserPermission::Roles::ADMIN
        expect(response).to be_success
      end
    end

    context "logged in as the user" do

      before { login_user membership.user }

      it "should fail and not update", :vcr do
        membership.update! role: TimelineUserPermission::Roles::PARTICIPANTS
        put 'update', id: membership.id,
          role: TimelineUserPermission::Roles::ADMIN

        membership.reload
        expect(membership.role).to eq TimelineUserPermission::Roles::PARTICIPANTS
        expect(response).not_to be_success
      end
    end

    context "not logged in" do

      before { logout_user }

      it "should fail and not update", :vcr do
        membership.update! role: TimelineUserPermission::Roles::PARTICIPANTS
        put 'update', id: membership.id,
          role: TimelineUserPermission::Roles::ADMIN

        membership.reload
        expect(membership.role).to eq TimelineUserPermission::Roles::PARTICIPANTS
        expect(response).not_to be_success
      end
    end
  end

  describe "POST 'create'" do

    context "logged in" do

      let(:user)     { FactoryGirl.create :user }
      let(:timeline) { FactoryGirl.create :timeline }
      before { login_user user }

      it "should create the membership and return it", :vcr do
        expect{
          post 'create', timeline_id: timeline.id
        }.to change(TimelineUserPermission, :count).by(1)
        expect(response).to be_success
        expect(assigns :membership).to be_a TimelineUserPermission
      end
    end

    context "not logged in" do

      before { logout_user }

      it "should refuse creating membership and fail", :vcr do
        id = membership.timeline.id
        expect{
          post 'create', timeline_id: id
        }.not_to change(TimelineUserPermission, :count)
        expect(response).not_to be_success
      end
    end
  end

end
