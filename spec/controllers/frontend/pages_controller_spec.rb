require 'spec_helper'

describe Frontend::PagesController do

  describe "GET 'page'" do
    it "returns http success" do
      get 'page'
      response.should be_success
    end

    it "should render 'index' by default" do
      get 'page'
      expect(response).to render_template('frontend/pages/index.haml')
    end

    it "should render correct template based on page param" do
      get 'page', page: 'admin/users'
      expect(response).to render_template('frontend/pages/admin/users.haml')
    end
  end

end
