
require 'spec_helper'

describe User do

  before do
    @user = User.new email: "foo@bar.com", password: "foobarbaz", first_name: "foo", last_name: "bar"
  end

  subject { @user }

  it "Should have a first name" do
    subject.first_name = ""
    subject.save
    expect(subject).to be_invalid
  end

  it "Should have a last name" do
    subject.last_name = ""
    subject.save
    expect(subject).to be_invalid
  end
end
