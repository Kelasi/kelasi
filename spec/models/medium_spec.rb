require 'spec_helper'

describe Medium do

  context 'validations' do

    context 'of a valid size file' do

      let(:medium) { FactoryGirl.build :document_file }

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

    context 'of a file with invalid file size' do

      let(:invalid_size_medium) { FactoryGirl.build :invalid_size_image }

      it 'should prevent from storing the file', :vcr do
        expect(invalid_size_medium).to be_invalid
      end
    end
  end
end
