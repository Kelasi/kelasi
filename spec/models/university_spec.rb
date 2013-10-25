require 'spec_helper'

describe University do

  before do
    @user = FactoryGirl.create :user
    @uni = FactoryGirl.create :university
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
