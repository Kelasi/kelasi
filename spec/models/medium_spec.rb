require 'spec_helper'

describe Medium do

  context 'validations' do

    subject { FactoryGirl.build :medium }

    it 'should have content type', :vcr do
      subject.content_type = nil
      expect(subject).to be_invalid
    end
  end
end
