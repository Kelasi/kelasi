require 'spec_helper'

describe TimelineUserPermission do

  describe 'validation' do

    subject { FactoryGirl.build :timeline_user_permission }

    it "should be valid with default values", :vcr do
      expect(subject).to be_valid
    end

    context 'role' do

      it "should have role", :vcr do
        subject.role = nil
        expect(subject).to be_invalid
      end

      it "should accept valid values", :vcr do
        TimelineUserPermission::Roles::AllRoles.each do |role|
          tup = FactoryGirl.build :timeline_user_permission, :role => role
          expect(tup).to be_valid
        end
      end

      it "should reject invalid values", :vcr do
        [0, 4].each do |role|
          tup = FactoryGirl.build :timeline_user_permission, :role => role
          expect(tup).to be_invalid
        end
      end
    end
  end
end
