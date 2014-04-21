require 'spec_helper'
require 'carrierwave/test/matchers'

describe MediumUploader do

  include CarrierWave::Test::Matchers

  let(:medium) { Medium.new }

  subject { MediumUploader.new medium, :medium }

  context 'MODE:disable_processing' do

    before do
      MediumUploader.enable_processing = false
    end

    after do
      subject.remove!
    end

    context 'in the case of valid file' do

      before do
        subject.store! File.open(File.join(Rails.root, 'spec/support/files/image.jpg'))
      end

      it 'should set the file content_type in model', :vcr do
        expect(subject.model.content_type).to eq subject.content_type
      end

      it 'should set the file size in model', :vcr do
        expect(subject.model.file_size).to eq subject.size
      end

      it 'should set the file name in model', :vcr do
        expect(subject.model.file_name).to eq 'image.jpg'
      end
    end
  end
end
