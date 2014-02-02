require 'spec_helper'

describe Timeline do
  context 'validations' do

    subject { FactoryGirl.build :timeline_with_member }

    it 'should have title' do
      subject.title = nil
      expect(subject).to be_invalid
    end
  end
end
