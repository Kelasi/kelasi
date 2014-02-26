require 'spec_helper'

describe TimelinePost do

  subject { FactoryGirl.build :timeline_post }

  context 'state' do
    it "should have state" do
      subject.state = nil
      expect(subject).to be_invalid
    end

    it "should accept valid values" do
      TimelinePost::States::AllStates.each do |state|
        subject.state = state
        expect(subject).to be_valid
      end
    end

    it "should reject invalid values" do
      invalid_states = [TimelinePost::States::AllStates.first - 1,
                        TimelinePost::States::AllStates.last  + 1]
      invalid_states.each do |state|
        subject.state = state
        expect(subject).to be_invalid
      end
    end
  end

  context 'post body' do
    it "should unable to save post with empty body" do
      subject.body = ''
      expect(subject).to be_invalid
    end
  end
end
