require 'spec_helper'

describe Backend::UsersController do

  describe "GET 'show'" do

    it "returns http success" do
      get 'show', id: 1
      response.should be_success
    end

    it "should return the correct user", :vcr do
      user = FactoryGirl.create :user
      get 'show', id: user.id
      expect(assigns :user).to eq user
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
end
