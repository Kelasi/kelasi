require 'spec_helper'
require 'uni_normalize'

describe :uni_normalize do

  it "should downcase the string" do
    expect(uni_normalize "ABC").to eq "abc"
  end

  it "should remove spaces" do
    expect(uni_normalize "a b").to eq "ab"
  end
end
