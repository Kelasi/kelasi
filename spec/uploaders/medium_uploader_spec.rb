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

      let(:filename) { "image.jpg" }

      before do
        subject.store! File.open(File.join(Rails.root, 'spec/support/files/image.jpg'))
      end

      it 'should make the file writable only to the owner and not executable', :vcr do
        expect(subject).to have_permissions 0644
      end

      it 'should change the file name to an UUID one and a specific directory structure', :vcr do
        expect(subject.filename).to match /\w{8}-\w{4}-\w{4}-\w{4}-\w{12}.\w{1,}/

        file_type = subject.content_type.split('/').first
        random_folder = filename.first 2
        expect(File.dirname(subject.filename)).to eq "#{file_type}/#{random_folder}"
      end

      it 'should set the file content_type in model', :vcr do
        expect(subject.model.content_type).to eq subject.content_type
      end

      it 'should set the file size in model', :vcr do
        expect(subject.model.file_size).to eq subject.size
      end

      it 'should set the file name in model', :vcr do
        expect(subject.model.file_name).to eq filename
      end

      it 'should store uploaded files in a specific store_dir', :vcr do
        expect(subject.store_dir).to eq "#{subject.mounted_as.to_s.pluralize}/"
      end
    end

    context 'in the case of files with Farsi basename' do

      before do
        subject.store! File.open(File.join(Rails.root, 'spec/support/files/فارسی.doc'))
      end

      it 'should save the Farsi name as the file_name in model', :vcr do
        expect(subject.model.file_name).to eq 'فارسی.doc'
      end
    end

    context 'in the case of invalid files' do

      it 'store the file should raise an error', :vcr do
        expect{
          subject.store! File.open(File.join(Rails.root, 'spec/support/files/invalid.file'))
        }.to raise_error CarrierWave::IntegrityError
      end
    end
  end

  context'MODE: enable_processing' do

    before do
      MediumUploader.enable_processing = true
    end

    after do
      MediumUploader.enable_processing = false
      subject.remove!
    end

    context 'in case of Image files' do

      before do
        medium.process_medium_upload = true
        subject.store! File.open(File.join(Rails.root, 'spec/support/files/image.jpg'))
      end

      it 'should create a thumbnail version with quality 85' do
        subject.thumb.should have_dimensions 64, 64
        expect(subject.thumb.get_quality).to eq 85
      end

      it 'should create a small version with quality 85' do
        subject.small.should be_no_larger_than 240, 240
        expect(subject.small.get_quality).to eq 85
      end

      it 'should create a large version with quality 85' do
        subject.large.should be_no_larger_than 720, 720
        expect(subject.large.get_quality).to eq 85
      end
    end
  end
end
