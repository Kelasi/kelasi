
require 'spec_helper'
require 'uni_normalize'

describe User do

  let(:atendance) { FactoryGirl.create :current_attendance }
  let(:user) { atendance.user }
  let(:university) { atendance.university }

  context 'validations' do
    subject { FactoryGirl.build :user }

    it "should be valid with default attributes", :vcr do
      expect(subject).to be_valid
    end

    it "Should have a first name", :vcr do
      subject.first_name = ""
      expect(subject).to be_invalid
    end

    it "Should have a last name", :vcr do
      subject.last_name = ""
      expect(subject).to be_invalid
    end

    it "should have an introducer", :vcr do
      subject.introducer = nil
      expect(subject).to be_invalid
    end

    it "should have a unique profile_name", :vcr do
      subject.profile_name = ''
      subject.save
      expect(subject).to be_invalid
    end
  end

  context 'relations' do

    let(:introduced_user) { FactoryGirl.create :introduced_user, introducer: user }

    subject { user }

    it 'should have atendances', :vcr do
      expect(subject.respond_to? :atendances).to be_true
      expect(subject.atendances).to eq [atendance]
    end

    it 'should have universities', :vcr do
      expect(subject.respond_to? :universities).to be_true
      expect(subject.universities).to eq [university]
    end

    it "should return currently attending universities", :vcr do
      expect(subject.currently_attending).to include university
    end

    it "should have an introducer", :vcr do
      expect(introduced_user.respond_to? :introducer).to be_true
      expect(introduced_user.introducer).to eq user
    end

    context 'timeline' do

      subject { FactoryGirl.create :user_with_timeline }

      it "should respond to timeline" do
        expect(subject).to respond_to :timelines
      end
    end
  end

  context 'profile name' do
    subject { FactoryGirl.build :user }
    let (:profile_name) { user.first_name.downcase + user.last_name.capitalize }

    it "should create a profile_name if user left it blank" do
      subject.profile_name = ''
      subject.save
      expect(subject.profile_name).to be_present
    end

    it "should create a profile_name with a specific algorithm" do
      subject.profile_name = ''
      subject.save
      expect(subject.profile_name).to eq profile_name
    end

    it "should create a random profile_name if the user's name already exists" do
      u = FactoryGirl.create :user, profile_name: ''
      subject.first_name = u.first_name
      subject.last_name = u.last_name
      subject.profile_name = ''
      subject.save
      regex = Regexp.new(profile_name+'\d+')
      expect(subject.profile_name).to match regex
    end

    it "should create a profile_name based on email in the case of invalid first or last name" do
      subject.first_name = "جان"
      subject.save
      expect(subject.profile_name).to eq subject.email.split('@').first
    end

    it "should create a random profile_name if the local part of the user's email already exist" do
      u = FactoryGirl.create :user, profile_name: subject.email.split('@').first
      subject.first_name = 'جان'
      subject.save
      regex = Regexp.new(subject.email.split('@').first+'\d+')
      expect(subject.profile_name).to match regex
    end
  end

  context 'tire' do

    subject { User.search user.first_name }

    it 'should not contain root in json', :vcr do
      expect(User.include_root_in_json).to be_false
    end

    it 'should have Tire functionality', :vcr do
      expect(subject.results.map {|m| m.id}).to include user.id.to_s
    end

    it 'should have id in search results', :vcr do
      expect(subject.results.last.respond_to? :id).to be_true
      expect(subject.results.map {|m| m.id}).to include user.id.to_s
    end

    it 'should have first_name in search results', :vcr do
      expect(subject.results.last.respond_to? :first_name).to be_true
      expect(subject.results.map {|m| m.first_name}).to include user.first_name
    end

    it 'should have last_name in search results', :vcr do
      expect(subject.results.last.respond_to? :last_name).to be_true
      expect(subject.results.map {|m| m.last_name}).to include user.last_name
    end

    it 'should have universities in search results', :vcr do
      expect(subject.results.last.respond_to? :universities).to be_true
      expect(subject.results.map {|m| m.universities}.flatten).to include uni_normalize university.name
    end

    it 'shoult be able to search by first name', :vcr do
      subject = User.search "first_name:#{user.first_name}", load: true
      expect(subject.results).to include user
    end

    it 'should be able to search by last name', :vcr do
      subject = User.search "last_name:#{user.last_name}", load: true
      expect(subject.results).to include user
    end

    it 'should be able to search by university name', :vcr do
      subject = User.search %Q(universities:*#{uni_normalize university.name}*), load: true
      expect(subject.results).to include user
    end

    describe :search_user do

      it "should search by first name", :vcr do
        subject = User.search_user first_name: user.first_name
        expect(subject).to include user
      end

      it "should search by last name", :vcr do
        subject = User.search_user last_name: user.last_name
        expect(subject).to include user
      end

      it "should search by university name", :vcr do
        subject = User.search_user university: university.name
        expect(subject).to include user
      end
    end
  end
end
