require 'spec_helper'

describe Medium do
  context 'validations' do

    let(:medium) { FactoryGirl.build :medium }

    it 'should have content type', :vcr do
      medium.content_type = nil
      expect(medium).to be_invalid
    end

    it 'should have file size', :vcr do
      medium.file_size = nil
      expect(medium).to be_invalid
    end

    it 'should have file name', :vcr do
      medium.file_name = nil
      expect(medium).to be_invalid
    end
  end
end
