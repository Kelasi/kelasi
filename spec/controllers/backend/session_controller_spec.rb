require 'spec_helper'

describe Backend::SessionController do

  describe "GET 'show'" do

    let(:user) { stub_model User }

    context "logged in" do

      before { login_user user }

      it "should set the user and return success" do
        get 'show'
        expect(assigns :user).to eq user
        expect(response).to be_success
      end
    end

    context "logged out" do

      before { logout_user }

      it "should not return success" do
        get 'show'
        expect(response).not_to be_success
      end
    end
  end

  describe "POST 'create'" do

    let(:password) { '12345678' }
    let(:user) { FactoryGirl.create :user, password: password }

    it "should fail with incorrect params" do
      post 'create'
      expect(response).not_to be_success
    end

    it "should fail with incorrect pasword", :vcr do
      post 'create', email: user.email, password: "#{password}1"
      expect(response).not_to be_success
    end

    it "should success with correct params", :vcr do
      post 'create', email: user.email, password: password
      expect(response).to be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "should logout" do
      login_user stub_model(User)
      delete 'destroy'
      expect(response).to be_success
      get 'show'
      expect(response).not_to be_success
    end
  end
end
