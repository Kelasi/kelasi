require 'spec_helper'
require 'valid_mime_types'

describe :MIME do

  context 'valid extensions' do
    it "should return an array" do
      expect(MIME::valid_extensions).to be_an Array
    end

    it "should return valid extensions" do
      expect(MIME::valid_extensions).to include MIME::Valid_types.values.first.first
    end
  end
end
