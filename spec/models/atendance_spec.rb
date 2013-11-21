require 'spec_helper'

describe Atendance do

  before do
    @user = FactoryGirl.create :user_with_university
  end
  subject {@user.atendances.first}

  it 'should have a user', :vcr do
    expect(subject.respond_to? :user).to be_true
    expect(subject.user).to eq @user
  end

  it 'should have a university', :vcr do
    expect(subject.respond_to? :university).to be_true
    expect(subject.university).to eq @user.universities.first
  end
end
