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
    it "returns http success" do
      post 'create'
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', id: 1
      response.should be_success
    end
  end

end
