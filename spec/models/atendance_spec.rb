require 'spec_helper'

describe Atendance do

  before do
    @user = User.create! do |u|
      u.first_name = "foo"
      u.last_name = "bar"
      u.email = "foo@bar.com"
      u.password = "12345678"
    end
    @user.universities.create! name: "baz"
  end
  subject {@user.atendances.first}

  it 'should have a user' do
    expect(subject.respond_to? :user).to be_true
    expect(subject.user).to eq @user
  end

  it 'should have a university' do
    expect(subject.respond_to? :university).to be_true
    expect(subject.university).to eq @user.universities.first
  end
end
