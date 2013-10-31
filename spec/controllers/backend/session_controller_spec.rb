require 'spec_helper'

describe Backend::SessionController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end

    it "should render the correct template" do
      get 'show'
      expect(response).to render_template "backend/session/show"
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
