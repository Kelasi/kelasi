require 'spec_helper'

describe "Router" do

  describe "User resources" do
    it "should fail to route 'GET users/index'" do
      expect(:get => '/api_/users').not_to be_routable
    end
  end
end
