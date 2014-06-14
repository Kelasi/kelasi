require 'spec_helper'

describe Timeline do

  context 'validations' do

    subject { FactoryGirl.build :timeline_with_member }

    it 'should have title' do
      subject.title = nil
      expect(subject).to be_invalid
    end
  end

  context :admin? do

    let(:timeline) { FactoryGirl.create :timeline_with_admin }
    let(:user) { timeline.users.first }

    it 'should return true when the user is the admin of the timeline', :vcr do
      expect(timeline.admin? user).to be_truthy
    end

    it 'should return false when the user is not the admin', :vcr do
      random_user = FactoryGirl.create :user
      expect(timeline.admin? random_user).to be_falsey
    end
  end

  context :add_member do

    subject { FactoryGirl.create :timeline }
    let(:user) { FactoryGirl.create :user }

    it "should raise error if anything other than a User passed in" do
      expect{subject.add_member true}.to raise_error
    end

    it "should add passed in user as a member(PARTICIPANT)", :vcr do
      subject.add_member user
      expect(subject.users).to include user
      expect(subject.role? user)
        .to eq TimelineUserPermission::Roles::PARTICIPANTS
    end

    it "should accept a role param", :vcr do
      AdminRole = TimelineUserPermission::Roles::ADMIN
      subject.add_member user, role: AdminRole
      expect(subject.role? user).to eq AdminRole
    end

    it "should return the constructed TimelineUserPermission", :vcr do
      expect(subject.add_member user).to be_a TimelineUserPermission
    end

    it "should return the already existing membership", :vcr do
      membership = subject.add_member user
      expect(subject.add_member user).to eq membership
    end
  end

  context :role? do

    subject { FactoryGirl.create :timeline_with_admin }
    let(:admin) { subject.users.first }
    let(:participant) do
      FactoryGirl.create(
        :timeline_user_permission,
        timeline: subject,
        role: TimelineUserPermission::Roles::PARTICIPANTS
      ).user
    end

    it "should return the correct role", :vcr do
      expect(subject.role? admin)
        .to eq TimelineUserPermission::Roles::ADMIN
      expect(subject.role? participant)
        .to eq TimelineUserPermission::Roles::PARTICIPANTS
    end
  end
end
