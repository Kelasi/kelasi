require 'spec_helper'

describe TimelinePost do

  subject { FactoryGirl.build :timeline_post }

  context 'state' do
    it "should have state", :vcr do
      subject.state = nil
      expect(subject).to be_invalid
    end

    it "should accept valid values", :vcr do
      TimelinePost::States::AllStates.each do |state|
        subject.state = state
        expect(subject).to be_valid
      end
    end

    it "should reject invalid values", :vcr do
      invalid_states = [TimelinePost::States::AllStates.first - 1,
                        TimelinePost::States::AllStates.last  + 1]
      invalid_states.each do |state|
        subject.state = state
        expect(subject).to be_invalid
      end
    end
  end

  context 'post body' do
    it "should unable to save post with empty body", :vcr do
      subject.body = ''
      expect(subject).to be_invalid
    end
  end

  context 'default scope' do

    before do
      FactoryGirl.create_list :timeline_post, 5
      @active = FactoryGirl.create :timeline_post
      @deactive = FactoryGirl.create :timeline_post
      @deactive.update! state: TimelinePost::States::DEACTIVE
    end

    subject { TimelinePost.all }

    it "should not have the deactive post", :vcr do
      expect(subject).not_to include @deactive
    end

    it "should have the active post as the first post", :vcr do
      expect(subject.first).to eq @active
    end
  end
end
