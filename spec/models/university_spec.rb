require 'spec_helper'

describe University do

  before do
    @user = User.create! do |u|
      u.first_name = "foo"
      u.last_name = "bar"
      u.email = "foo@bar.com"
      u.password = "12345678"
    end
    @uni = University.create! name: "baz"
    @atendance = Atendance.create! user: @user, university: @uni
  end
  subject {@uni}

  it 'should have atendances' do
    expect(subject.respond_to? :atendances).to be_true
    expect(subject.atendances).to eq [@atendance]
  end

  it 'should have users' do
    expect(subject.respond_to? :users).to be_true
    expect(subject.users).to eq [@user]
  end
end
