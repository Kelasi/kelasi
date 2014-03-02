require 'spec_helper'

describe Backend::UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: 1
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      put 'update', id: 1
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should create a new user with right params", :vcr do
      u = FactoryGirl.create :user_with_university
      params = {
        first_name: 'first',
        last_name: 'last',
        university: u.universities.first.name,
        introducer: u.id,
        email: 'last@google.com',
        password: '123456',
      }
      user_count = User.count
      post 'create', params
      expect(response).to be_success
      expect(User.count).to be user_count + 1
      expect(assigns(:user).introducer).to eq u
      expect(assigns(:user).universities).to eq [u.universities.first]
    end

    it "should fail without parameters" do
      post 'create'
      expect(response).not_to be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', id: 1
      response.should be_success
    end
  end

end
