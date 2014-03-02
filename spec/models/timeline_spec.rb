require 'spec_helper'

describe Timeline do
  context 'validations' do

    subject { FactoryGirl.build :timeline_with_member }

    it 'should have title' do
      subject.title = nil
      expect(subject).to be_invalid
    end
  end

  context 'Admin?' do

    let(:timeline) { FactoryGirl.create :timeline_with_admin }
    let(:user) { timeline.users.first }

    it 'should return true when the user is the admin of the timeline', :vcr do
      expect(timeline.admin? user).to be_true
    end

    it 'should return false when the user is not the admin', :vcr do
      random_user = FactoryGirl.create :user
      expect(timeline.admin? random_user).to be_false
    end
  end
end
