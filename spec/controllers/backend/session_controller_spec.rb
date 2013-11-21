require 'spec_helper'

describe Backend::SessionController do

  before do
    @user = FactoryGirl.create :user
    @user.password = FactoryGirl.attributes_for(:user)[:password]
  end

  describe "GET 'show'" do
    it "returns http success", :vcr do
      get 'show'
      response.should be_success
    end

    it "should render the correct template", :vcr do
      get 'show'
      expect(response).to render_template "backend/session/show"
    end

    it "should set logged_in to false when logged out", :vcr do
      logout_user
      get 'show'
      expect(assigns(:response)[:logged_in]).to be_false
    end

    it "should set logged_in to true when logged in", :vcr do
      login_user
      get 'show'
      expect(assigns(:response)[:logged_in]).to be_true
    end
  end

  describe "POST 'create'" do
    it "should return http 403 when incorrect params sent", :vcr do
      post 'create'
      expect(response.status).to be 403
    end

    it "should return http 403 when incorrect pasword send", :vcr do
      post 'create', email: @user.email, password: "#{@user.password}1"
      expect(response.status).to be 403
    end

    it "should return http success when correct params passed", :vcr do
      post 'create', email: @user.email, password: @user.password
      expect(response).to be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success", :vcr do
      delete 'destroy'
      response.should be_success
    end

    it "should logout", :vcr do
      login_user
      delete 'destroy'
      get 'show'
      expect(assigns(:response)[:logged_in]).to be_false
    end
  end
end
